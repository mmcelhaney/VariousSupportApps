import React, { useState, useEffect } from 'react';
import { CheckCircle, Circle, Book, Code, ExternalLink, X } from 'lucide-react';

const DataAnalysisGuide = () => {
  const [activeTab, setActiveTab] = useState('cleaning');
  const [completedItems, setCompletedItems] = useState({});
  const [selectedConcept, setSelectedConcept] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadProgress = async () => {
      try {
        const result = await window.storage.get('data-analysis-progress');
        if (result && result.value) {
          setCompletedItems(JSON.parse(result.value));
        }
      } catch (error) {
        console.log('No saved progress found, starting fresh');
      } finally {
        setLoading(false);
      }
    };
    loadProgress();
  }, []);

  useEffect(() => {
    if (!loading) {
      const saveProgress = async () => {
        try {
          await window.storage.set('data-analysis-progress', JSON.stringify(completedItems));
        } catch (error) {
          console.error('Failed to save progress:', error);
        }
      };
      saveProgress();
    }
  }, [completedItems, loading]);

  const toggleComplete = (id) => {
    setCompletedItems(prev => ({
      ...prev,
      [id]: !prev[id]
    }));
  };

  const concepts = {
    cleaning: [
      {
        id: 'dropna',
        title: 'dropna()',
        description: 'Remove missing values from a dataset',
        python: `import pandas as pd
# Remove rows with any missing values
df_clean = df.dropna()

# Remove columns with missing values
df_clean = df.dropna(axis=1)`,
        r: `# Remove rows with any NA
df_clean <- na.omit(df)

# Remove specific columns
df_clean <- df[complete.cases(df), ]`,
        sql: `-- Filter out NULL values
SELECT * FROM table
WHERE column1 IS NOT NULL 
  AND column2 IS NOT NULL;`,
        resources: [
          { title: 'Pandas dropna() docs', url: 'https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.dropna.html' },
          { title: 'Handling Missing Data Guide', url: 'https://www.kaggle.com/learn/data-cleaning' }
        ]
      },
      {
        id: 'fillna',
        title: 'fillna()',
        description: 'Fill missing values with a specified value or method',
        python: `# Fill with specific value
df['column'] = df['column'].fillna(0)

# Forward fill
df['column'] = df['column'].fillna(method='ffill')

# Fill with mean
df['column'] = df['column'].fillna(df['column'].mean())`,
        r: `# Replace NA with 0
df$column[is.na(df$column)] <- 0

# Fill with mean
df$column[is.na(df$column)] <- mean(df$column, na.rm=TRUE)`,
        sql: `-- Use COALESCE to replace NULL
SELECT COALESCE(column, 0) as column
FROM table;

-- Use IFNULL in MySQL
SELECT IFNULL(column, 0) FROM table;`,
        resources: [
          { title: 'Pandas fillna() docs', url: 'https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.fillna.html' },
          { title: 'Imputation Strategies', url: 'https://scikit-learn.org/stable/modules/impute.html' }
        ]
      },
      {
        id: 'astype',
        title: 'astype()',
        description: 'Convert the data type of a column',
        python: `# Convert to numeric
df['age'] = df['age'].astype(int)

# Convert to string
df['id'] = df['id'].astype(str)

# Convert to datetime
df['date'] = pd.to_datetime(df['date'])`,
        r: `# Convert to numeric
df$age <- as.numeric(df$age)

# Convert to factor
df$category <- as.factor(df$category)

# Convert to date
df$date <- as.Date(df$date)`,
        sql: `-- Cast to integer
SELECT CAST(column AS INTEGER) FROM table;

-- Convert to date
SELECT CAST(date_string AS DATE) FROM table;`,
        resources: [
          { title: 'Pandas Data Types', url: 'https://pandas.pydata.org/docs/user_guide/basics.html#dtypes' },
          { title: 'SQL CAST Function', url: 'https://www.w3schools.com/sql/func_sqlserver_cast.asp' }
        ]
      },
      {
        id: 'nan_to_num',
        title: 'nan_to_num()',
        description: 'Replace NaN with a numeric value',
        python: `import numpy as np

# Replace NaN with 0
arr_clean = np.nan_to_num(arr, nan=0.0)

# Replace with specific values
arr_clean = np.nan_to_num(arr, nan=0, posinf=999, neginf=-999)`,
        r: `# Replace NaN with 0
df[is.na(df)] <- 0

# Using tidyr
library(tidyr)
df <- df %>% replace_na(list(column = 0))`,
        sql: `-- Handle NaN/NULL in calculations
SELECT COALESCE(NULLIF(column, 'NaN'), 0) 
FROM table;`,
        resources: [
          { title: 'NumPy nan_to_num', url: 'https://numpy.org/doc/stable/reference/generated/numpy.nan_to_num.html' },
          { title: 'tidyr replace_na', url: 'https://tidyr.tidyverse.org/reference/replace_na.html' }
        ]
      },
      {
        id: 'reshape',
        title: 'reshape()',
        description: 'Reshape arrays without changing their data',
        python: `import numpy as np

# Reshape array
arr = np.array([1, 2, 3, 4, 5, 6])
reshaped = arr.reshape(2, 3)

# Pandas pivot
df_pivot = df.pivot(index='date', columns='type', values='value')`,
        r: `# Reshape matrix
matrix <- matrix(1:6, nrow=2, ncol=3)

# Pivot wider/longer with tidyr
library(tidyr)
df_wide <- pivot_wider(df, names_from=type, values_from=value)`,
        sql: `-- Pivot in SQL
SELECT date,
  MAX(CASE WHEN type='A' THEN value END) as A,
  MAX(CASE WHEN type='B' THEN value END) as B
FROM table
GROUP BY date;`,
        resources: [
          { title: 'NumPy reshape', url: 'https://numpy.org/doc/stable/reference/generated/numpy.reshape.html' },
          { title: 'Pandas Reshaping', url: 'https://pandas.pydata.org/docs/user_guide/reshaping.html' }
        ]
      },
      {
        id: 'unique',
        title: 'unique()',
        description: 'Get all unique values from a column or array',
        python: `# Get unique values
unique_vals = df['category'].unique()

# Count unique values
n_unique = df['category'].nunique()

# Value counts
counts = df['category'].value_counts()`,
        r: `# Get unique values
unique_vals <- unique(df$category)

# Count unique
n_unique <- length(unique(df$category))

# Frequency table
table(df$category)`,
        sql: `-- Get distinct values
SELECT DISTINCT category FROM table;

-- Count distinct
SELECT COUNT(DISTINCT category) FROM table;`,
        resources: [
          { title: 'Pandas unique', url: 'https://pandas.pydata.org/docs/reference/api/pandas.Series.unique.html' },
          { title: 'SQL DISTINCT', url: 'https://www.w3schools.com/sql/sql_distinct.asp' }
        ]
      }
    ],
    eda: [
      {
        id: 'describe',
        title: 'describe()',
        description: 'Generate summary statistics',
        python: `# Basic statistics
summary = df.describe()

# Include all columns
summary = df.describe(include='all')

# Specific percentiles
summary = df.describe(percentiles=[.25, .5, .75, .9])`,
        r: `# Summary statistics
summary(df)

# Using dplyr
library(dplyr)
df %>% summarise_all(list(mean=mean, sd=sd), na.rm=TRUE)`,
        sql: `-- Basic statistics
SELECT 
  COUNT(*) as count,
  AVG(column) as mean,
  MIN(column) as min,
  MAX(column) as max
FROM table;`,
        resources: [
          { title: 'Pandas describe', url: 'https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.describe.html' },
          { title: 'Descriptive Statistics Guide', url: 'https://www.statology.org/descriptive-statistics/' }
        ]
      },
      {
        id: 'groupby',
        title: 'groupby()',
        description: 'Group data by one or more columns',
        python: `# Group by single column
grouped = df.groupby('category').mean()

# Multiple columns
grouped = df.groupby(['region', 'year']).agg({
    'sales': 'sum',
    'profit': 'mean'
})`,
        r: `# Using dplyr
library(dplyr)
grouped <- df %>%
  group_by(category) %>%
  summarise(avg_value = mean(value))`,
        sql: `-- Group by with aggregation
SELECT category, AVG(value) as avg_value
FROM table
GROUP BY category;`,
        resources: [
          { title: 'Pandas groupby', url: 'https://pandas.pydata.org/docs/user_guide/groupby.html' },
          { title: 'dplyr group_by', url: 'https://dplyr.tidyverse.org/reference/group_by.html' }
        ]
      },
      {
        id: 'corr',
        title: 'corr()',
        description: 'Compute correlations between columns',
        python: `# Correlation matrix
corr_matrix = df.corr()

# Specific method
corr_matrix = df.corr(method='spearman')

# Between two columns
correlation = df['col1'].corr(df['col2'])`,
        r: `# Correlation matrix
cor(df[, numeric_cols], use="complete.obs")

# Specific method
cor(df[, numeric_cols], method="spearman")`,
        sql: `-- Correlation in SQL (PostgreSQL)
SELECT CORR(col1, col2) FROM table;`,
        resources: [
          { title: 'Pandas corr', url: 'https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.corr.html' },
          { title: 'Correlation Analysis', url: 'https://www.statisticshowto.com/probability-and-statistics/correlation-coefficient-formula/' }
        ]
      },
      {
        id: 'plot',
        title: 'plot()',
        description: 'Plot lines or basic graphs',
        python: `import matplotlib.pyplot as plt

# Basic line plot
df.plot(x='date', y='value')
plt.show()

# Multiple lines
df.plot(x='date', y=['sales', 'profit'])`,
        r: `# Base R plot
plot(df$x, df$y, type='l')

# ggplot2
library(ggplot2)
ggplot(df, aes(x=date, y=value)) +
  geom_line()`,
        javascript: `// Using D3.js
const line = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.value));
  
svg.append("path")
  .datum(data)
  .attr("d", line);`,
        resources: [
          { title: 'Matplotlib Tutorial', url: 'https://matplotlib.org/stable/tutorials/index.html' },
          { title: 'ggplot2 Documentation', url: 'https://ggplot2.tidyverse.org/' }
        ]
      },
      {
        id: 'hist',
        title: 'hist()',
        description: 'Create histograms',
        python: `# Simple histogram
df['age'].hist(bins=20)

# With matplotlib
plt.hist(df['age'], bins=20, edgecolor='black')
plt.xlabel('Age')
plt.ylabel('Frequency')`,
        r: `# Base R
hist(df$age, breaks=20, main="Age Distribution")

# ggplot2
ggplot(df, aes(x=age)) +
  geom_histogram(bins=20, fill="steelblue")`,
        javascript: `// D3.js histogram
const histogram = d3.histogram()
  .domain(xScale.domain())
  .thresholds(xScale.ticks(20));

const bins = histogram(data);`,
        resources: [
          { title: 'Matplotlib hist', url: 'https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.hist.html' },
          { title: 'Histogram Guide', url: 'https://www.datacamp.com/tutorial/histograms-matplotlib' }
        ]
      },
      {
        id: 'scatter',
        title: 'scatter()',
        description: 'Generate scatter plots',
        python: `# Basic scatter
plt.scatter(df['x'], df['y'])

# With colors and sizes
plt.scatter(df['x'], df['y'], c=df['category'], s=df['size'])`,
        r: `# Base R
plot(df$x, df$y, pch=16)

# ggplot2
ggplot(df, aes(x=x, y=y, color=category)) +
  geom_point()`,
        javascript: `// D3.js scatter
svg.selectAll("circle")
  .data(data)
  .enter()
  .append("circle")
  .attr("cx", d => xScale(d.x))
  .attr("cy", d => yScale(d.y))
  .attr("r", 5);`,
        resources: [
          { title: 'Seaborn scatterplot', url: 'https://seaborn.pydata.org/generated/seaborn.scatterplot.html' },
          { title: 'Scatter Plot Guide', url: 'https://www.data-to-viz.com/graph/scatter.html' }
        ]
      },
      {
        id: 'boxplot',
        title: 'sns.boxplot()',
        description: 'Visualize distributions using a box plot',
        python: `import seaborn as sns

# Basic boxplot
sns.boxplot(data=df, x='category', y='value')

# With hue
sns.boxplot(data=df, x='category', y='value', hue='region')`,
        r: `# Base R
boxplot(value ~ category, data=df)

# ggplot2
ggplot(df, aes(x=category, y=value)) +
  geom_boxplot()`,
        javascript: `// Using Plotly
Plotly.newPlot('chart', [{
  y: data,
  type: 'box',
  name: 'Distribution'
}]);`,
        resources: [
          { title: 'Seaborn boxplot', url: 'https://seaborn.pydata.org/generated/seaborn.boxplot.html' },
          { title: 'Understanding Boxplots', url: 'https://www.simplypsychology.org/boxplots.html' }
        ]
      }
    ],
    visualization: [
      {
        id: 'bar',
        title: 'bar()',
        description: 'Draw bar charts',
        python: `# Vertical bar chart
df.plot.bar(x='category', y='value')

# Horizontal
df.plot.barh(x='category', y='value')`,
        r: `# Base R
barplot(df$value, names.arg=df$category)

# ggplot2
ggplot(df, aes(x=category, y=value)) +
  geom_bar(stat="identity")`,
        javascript: `// D3.js bar chart
svg.selectAll("rect")
  .data(data)
  .enter()
  .append("rect")
  .attr("x", (d, i) => i * barWidth)
  .attr("y", d => height - yScale(d.value))
  .attr("width", barWidth)
  .attr("height", d => yScale(d.value));`,
        resources: [
          { title: 'Matplotlib bar charts', url: 'https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.bar.html' },
          { title: 'Bar Chart Best Practices', url: 'https://www.storytellingwithdata.com/blog/2020/2/19/bar-charts' }
        ]
      },
      {
        id: 'xlabel',
        title: 'xlabel()',
        description: 'Label chart axes',
        python: `import matplotlib.pyplot as plt

plt.xlabel('Time')
plt.ylabel('Temperature')
plt.title('Temperature Over Time')`,
        r: `# Base R
plot(x, y, xlab="Time", ylab="Temperature")

# ggplot2
ggplot(df, aes(x, y)) +
  geom_line() +
  labs(x="Time", y="Temperature")`,
        javascript: `// D3.js axes
svg.append("text")
  .attr("x", width / 2)
  .attr("y", height + 40)
  .text("Time");`,
        resources: [
          { title: 'Matplotlib Labels', url: 'https://matplotlib.org/stable/tutorials/introductory/pyplot.html' },
          { title: 'Chart Labeling Guide', url: 'https://www.interaction-design.org/literature/article/labeling-charts' }
        ]
      },
      {
        id: 'barplot',
        title: 'sns.barplot()',
        description: 'Bar chart with statistical estimation',
        python: `import seaborn as sns

# Bar plot with error bars
sns.barplot(data=df, x='category', y='value', ci=95)

# Without error bars
sns.barplot(data=df, x='category', y='value', ci=None)`,
        r: `# Using ggplot2 with stat_summary
ggplot(df, aes(x=category, y=value)) +
  stat_summary(fun=mean, geom="bar")`,
        javascript: `// Using Chart.js
new Chart(ctx, {
  type: 'bar',
  data: {
    labels: categories,
    datasets: [{
      label: 'Average Value',
      data: averages
    }]
  }
});`,
        resources: [
          { title: 'Seaborn barplot', url: 'https://seaborn.pydata.org/generated/seaborn.barplot.html' },
          { title: 'Statistical Visualization', url: 'https://clauswilke.com/dataviz/' }
        ]
      },
      {
        id: 'violinplot',
        title: 'sns.violinplot()',
        description: 'Combine KDE and boxplot',
        python: `# Basic violin plot
sns.violinplot(data=df, x='category', y='value')

# Split by hue
sns.violinplot(data=df, x='category', y='value', hue='group', split=True)`,
        r: `# Using ggplot2
ggplot(df, aes(x=category, y=value)) +
  geom_violin()`,
        javascript: `// Using Plotly
Plotly.newPlot('chart', [{
  type: 'violin',
  y: data,
  box: { visible: true }
}]);`,
        resources: [
          { title: 'Seaborn violinplot', url: 'https://seaborn.pydata.org/generated/seaborn.violinplot.html' },
          { title: 'Violin Plot Explained', url: 'https://www.data-to-viz.com/graph/violin.html' }
        ]
      },
      {
        id: 'lineplot',
        title: 'sns.lineplot()',
        description: 'Plot line graphs with confidence intervals',
        python: `# Line plot with CI
sns.lineplot(data=df, x='time', y='value')

# Multiple lines
sns.lineplot(data=df, x='time', y='value', hue='category')`,
        r: `# ggplot2 line plot
ggplot(df, aes(x=time, y=value, color=category)) +
  geom_line()`,
        javascript: `// D3.js line
const line = d3.line()
  .x(d => xScale(d.time))
  .y(d => yScale(d.value));`,
        resources: [
          { title: 'Seaborn lineplot', url: 'https://seaborn.pydata.org/generated/seaborn.lineplot.html' },
          { title: 'Line Chart Design', url: 'https://www.storytellingwithdata.com/blog/2018/3/9/bring-on-the-line-graphs' }
        ]
      },
      {
        id: 'scatter_express',
        title: 'plotly.express.scatter()',
        description: 'Interactive scatter plot',
        python: `import plotly.express as px

# Basic interactive scatter
fig = px.scatter(df, x='x', y='y', color='category')
fig.show()`,
        r: `# Using plotly in R
library(plotly)
plot_ly(df, x=~x, y=~y, color=~category, 
        type='scatter', mode='markers')`,
        javascript: `// Plotly.js
Plotly.newPlot('chart', [{
  x: xData,
  y: yData,
  mode: 'markers',
  type: 'scatter'
}]);`,
        resources: [
          { title: 'Plotly Express', url: 'https://plotly.com/python/plotly-express/' },
          { title: 'Interactive Viz Guide', url: 'https://plotly.com/python/tutorials/' }
        ]
      }
    ]
  };

  const tabs = [
    { id: 'cleaning', label: 'Data Cleaning', icon: '🧹' },
    { id: 'eda', label: 'EDA', icon: '🔍' },
    { id: 'visualization', label: 'Visualization', icon: '📊' }
  ];

  const getProgress = (tabId) => {
    const tabConcepts = concepts[tabId];
    const completed = tabConcepts.filter(c => completedItems[c.id]).length;
    return Math.round((completed / tabConcepts.length) * 100);
  };

  const ConceptModal = ({ concept, onClose }) => {
    const [activeLanguage, setActiveLanguage] = useState('python');
    
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4" onClick={onClose}>
        <div className="bg-white rounded-lg max-w-4xl w-full max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
          <div className="sticky top-0 bg-white border-b p-4 flex justify-between items-center">
            <h3 className="text-2xl font-bold text-gray-800">{concept.title}</h3>
            <button onClick={onClose} className="text-gray-500 hover:text-gray-700">
              <X size={24} />
            </button>
          </div>
          
          <div className="p-6">
            <p className="text-gray-600 mb-6">{concept.description}</p>
            
            <div className="mb-4">
              <div className="flex gap-2 mb-4 flex-wrap">
                {concept.python && (
                  <button
                    onClick={() => setActiveLanguage('python')}
                    className={`px-4 py-2 rounded transition ${activeLanguage === 'python' ? 'bg-blue-600 text-white' : 'bg-gray-200 hover:bg-gray-300'}`}
                  >
                    Python
                  </button>
                )}
                {concept.r && (
                  <button
                    onClick={() => setActiveLanguage('r')}
                    className={`px-4 py-2 rounded transition ${activeLanguage === 'r' ? 'bg-blue-600 text-white' : 'bg-gray-200 hover:bg-gray-300'}`}
                  >
                    R
                  </button>
                )}
                {concept.sql && (
                  <button
                    onClick={() => setActiveLanguage('sql')}
                    className={`px-4 py-2 rounded transition ${activeLanguage === 'sql' ? 'bg-blue-600 text-white' : 'bg-gray-200 hover:bg-gray-300'}`}
                  >
                    SQL
                  </button>
                )}
                {concept.javascript && (
                  <button
                    onClick={() => setActiveLanguage('javascript')}
                    className={`px-4 py-2 rounded transition ${activeLanguage === 'javascript' ? 'bg-blue-600 text-white' : 'bg-gray-200 hover:bg-gray-300'}`}
                  >
                    JavaScript
                  </button>
                )}
              </div>
              
              <div className="bg-gray-900 text-green-400 p-4 rounded font-mono text-sm overflow-x-auto">
                <pre>{concept[activeLanguage]}</pre>
              </div>
            </div>
            
            <div className="mt-6">
              <h4 className="font-semibold text-lg mb-3 flex items-center gap-2">
                <Book size={20} />
                Additional Resources
              </h4>
              <div className="space-y-2">
                {concept.resources.map((resource, idx) => (
                  <a
                    key={idx}
                    href={resource.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline"
                  >
                    <ExternalLink size={16} />
                    {resource.title}
                  </a>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center">
        <div className="text-xl text-gray-600">Loading your progress...</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 p-6">
      <div className="max-w-7xl mx-auto">
        <div className="text-center mb-8">
          <h1 className="text-4xl font-bold text-gray-800 mb-2">
            Interactive Data Analysis Guide
          </h1>
          <p className="text-gray-600">
            Master Data Cleaning, EDA, and Visualization with Python, R, SQL & JavaScript
          </p>
        </div>

        <div className="flex gap-4 mb-6 flex-wrap justify-center">
          {tabs.map(tab => {
            const progress = getProgress(tab.id);
            return (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`flex flex-col items-center gap-2 px-6 py-3 rounded-lg font-semibold transition-all ${
                  activeTab === tab.id
                    ? 'bg-blue-600 text-white shadow-lg'
                    : 'bg-white text-gray-700 hover:bg-gray-50'
                }`}
              >
                <span className="text-2xl">{tab.icon}</span>
                <span>{tab.label}</span>
                <span className="text-xs">{progress}% complete</span>
              </button>
            );
          })}
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {concepts[activeTab].map(concept => (
            <div
              key={concept.id}
              className="bg-white rounded-lg p-4 shadow hover:shadow-lg transition-shadow"
            >
              <div className="flex items-start justify-between mb-3">
                <div className="flex-1">
                  <h3 className="font-bold text-lg text-gray-800 mb-1">{concept.title}</h3>
                  <p className="text-sm text-gray-600">{concept.description}</p>
                </div>
                <button
                  onClick={() => toggleComplete(concept.id)}
                  className="ml-2 flex-shrink-0"
                >
                  {completedItems[concept.id] ? (
                    <CheckCircle size={24} className="text-green-500" />
                  ) : (
                    <Circle size={24} className="text-gray-300" />
                  )}
                </button>
              </div>
              
              <button
                onClick={() => setSelectedConcept(concept)}
                className="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition flex items-center justify-center gap-2"
              >
                <Code size={16} />
                View Code & Resources
              </button>
            </div>
          ))}
        </div>

        {selectedConcept && (
          <ConceptModal
            concept={selectedConcept}
            onClose={() => setSelectedConcept(null)}
          />
        )}

        <div className="mt-12 bg-white rounded-lg p-6 shadow">
          <h2 className="text-2xl font-bold text-gray-800 mb-4">Reference Images</h2>
          <p className="text-gray-600 mb-4">
            This guide is based on comprehensive data analysis infographics covering essential techniques for data cleaning, exploratory data analysis, and visualization storytelling across Python, R, SQL, and JavaScript.
          </p>
          <div className="text-sm text-gray-500">
            <p><strong>Prompt used to create this guide:</strong></p>
            <p className="mt-2 italic">
              "Generate an HTML app with JavaScript that provides actionable and clickable guide for Data Analysis to resources for code snippets, tutorials, descriptions, illustrations for each of these concepts from the graphic. It should have 3 tabs: Data Cleaning, Exploratory Data Analysis (EDA), and Data Visualization Storytelling. Use a clickable tile for each concept and each should have a clickable checkmark that I can use to mark the concept as complete."
            </p>
            <p className="mt-4 text-gray-600">
              Your progress is automatically saved and will persist across sessions. Click on any concept tile to view detailed code examples in Python, R, SQL, and JavaScript, along with helpful learning resources.
            </p>
          </div>
        </div>

        <div className="mt-8 text-center text-gray-600">
          <p>Created with ❤️ for Data Analysts and Scientists</p>
          <p className="text-sm mt-2">Track your learning journey • Master multiple languages • Build your skills</p>
        </div>
      </div>
    </div>
  );
};

export default DataAnalysisGuide;