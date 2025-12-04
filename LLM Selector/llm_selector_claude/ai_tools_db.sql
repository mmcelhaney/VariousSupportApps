-- AI Tools Database Schema
CREATE TABLE tools (
  id TEXT PRIMARY KEY,
  name TEXT,
  category TEXT,
  best_for TEXT,
  pricing TEXT,
  signup_url TEXT,
  strengths TEXT,
  use_cases TEXT,
  icon TEXT,
  platform TEXT
);

CREATE TABLE scores (
  task_type TEXT,
  tool_id TEXT,
  score REAL,
  PRIMARY KEY (task_type, tool_id)
);

-- Insert LLM Tools
INSERT INTO tools VALUES 
('chatgpt', 'ChatGPT', 'chat', 'Creative content, coding, and everyday productivity', 'Free tier available, Plus $20/month', 'https://chat.openai.com', 'Multimodal capabilities|Advanced reasoning|Custom GPTs|Long-term projects', 'Writing blog posts|Debugging code|Creating presentations|Brainstorming', '🌀', 'web,mobile,desktop'),
('claude', 'Claude', 'chat', 'Deep reading and comprehension', 'Free tier available, Pro $20/month', 'https://claude.ai', '200K+ token context|Complex text analysis|Balanced tone|Ethical reasoning', 'Analyzing contracts|Research papers|Legal review|Technical writing', '✦', 'web,mobile,desktop'),
('perplexity', 'Perplexity', 'chat', 'Verified research and fact-checking', 'Free tier available, Pro $20/month', 'https://perplexity.ai', 'Always cites sources|Real-time web data|Research summarization|Quick answers', 'Academic research|Market analysis|News summaries|Documentation', '◈', 'web,mobile'),
('grok', 'Grok', 'chat', 'Real-time trends and pop culture', 'With X Premium ($8-16/month)', 'https://x.com', 'Real-time social media|Punchy humor|Breaking events|Viral content', 'Trending topics|Social media content|News monitoring|Sentiment analysis', '⦿', 'web,mobile'),
('gemini', 'Gemini', 'chat', 'Google Workspace integration', 'Free tier available, Advanced $20/month', 'https://gemini.google.com', 'Google Workspace integration|Real-time search|Team collaboration|Seamless workflows', 'Google Docs|Sheet analysis|Email drafting|Calendar management', '◆', 'web,mobile'),
('character_ai', 'Character AI', 'chat', 'Roleplay and character conversations', 'Free with Plus $9.99/month', 'https://character.ai', 'Custom characters|Immersive conversations|Creative storytelling|Entertainment', 'Creative writing|Entertainment|Language practice|Character development', '🎭', 'web,mobile'),
('pi', 'Pi', 'chat', 'Personal AI companion', 'Free', 'https://pi.ai', 'Empathetic responses|Personal support|Natural conversations|Voice capabilities', 'Daily chat|Personal advice|Emotional support|Casual conversation', '💬', 'web,mobile');

-- Insert Image Generation Tools
INSERT INTO tools VALUES
('midjourney', 'Midjourney', 'images', 'Hyper-realistic and artistic visuals', 'From $10/month', 'https://midjourney.com', 'Hyper-realistic output|Artistic control|High resolution|Unique aesthetic', 'Artistic visuals|Design work|Marketing assets|Concept art', '🎨', 'discord'),
('dalle3', 'DALL-E 3', 'images', 'Text rendering and prompt understanding', 'Included with ChatGPT Plus $20/month', 'https://chat.openai.com', 'Precise text-to-image|Complex prompts|Text rendering|Vision-to-visual', 'Product mockups|Marketing content|Illustrations|Creative concepts', '🖼️', 'web'),
('firefly', 'Adobe Firefly', 'images', 'Professional commercial use', 'Included in Adobe Creative Cloud', 'https://firefly.adobe.com', 'Licensed training data|Commercial safety|Photoshop integration|Generative Fill', 'Professional editing|Commercial projects|Brand assets|Advanced manipulation', '🔥', 'web,adobe'),
('stable_diffusion', 'Stable Diffusion', 'images', 'Open-source customization', 'Free (self-hosted)', 'https://stability.ai', 'Open-source|Extensive customization|Negative prompts|Local control', 'Custom models|Developer projects|Research|Specialized generation', '🌟', 'desktop,api'),
('canva_magic', 'Canva Magic Media', 'images', 'Social media and marketing design', 'Free; paid from $12.99/month', 'https://canva.com', 'Integrated design platform|User-friendly|Quick graphics|Template library', 'Social media|Presentations|Marketing materials|Quick designs', '✨', 'web,mobile'),
('stockimg', 'StockimgAI', 'images', 'Stock and social media images', 'From $29/month', 'https://stockimg.ai', 'Social media templates|Stock images|Quick generation|Brand kits', 'Social media|Marketing|Stock photography|Brand content', '📸', 'web'),
('bria', 'BRIA', 'images', 'High-quality commercial images', 'Enterprise pricing', 'https://bria.ai', 'Enterprise-grade|Commercial licensing|High quality|API access', 'Enterprise content|Commercial projects|Scalable generation|API integration', '🏢', 'api'),
('dreamina', 'Dreamina', 'images', 'AI image creation and editing', 'Free tier available', 'https://dreamina.ai', 'Image editing|Creative generation|Multiple styles|User-friendly', 'Creative projects|Photo editing|Artistic generation|Design work', '✨', 'web');

-- Insert Video Generation Tools
INSERT INTO tools VALUES
('sora', 'OpenAI Sora', 'videos', 'Cinematic realism and storytelling', 'Not yet widely available', 'https://openai.com/sora', 'Cinematic quality|Long coherent scenes|Realistic movements|Stunning visuals', 'Cinematic content|Storytelling|High-quality videos|Creative production', '🎬', 'api'),
('veo', 'Google Veo', 'videos', 'Creative production with 4K resolution', 'Google AI Studio access', 'https://deepmind.google/technologies/veo/', 'Advanced camera controls|4K resolution|Photorealistic|Natural physics', 'Professional videos|Creative control|Cinematic production|High-res content', '📹', 'web'),
('veo_canvas', 'Veo 3.1 Canvas', 'videos', 'Extended video editing and generation', 'Google AI access', 'https://deepmind.google/technologies/veo/', 'Extended editing|Canvas interface|Advanced controls|High quality', 'Video editing|Professional production|Creative projects|Advanced generation', '🎥', 'web'),
('runway', 'Runway ML', 'videos', 'Full editing workflow', 'Free plan; Pro from $15/month', 'https://runwayml.com', 'Text-to-video|Image-to-video|Motion Brush|Inpainting|Full editing suite', 'Video editing|AI effects|Motion graphics|Creative production', '🏃', 'web'),
('synthesia', 'Synthesia', 'videos', 'Training and explainer videos with AI avatars', 'Starts at $22/month', 'https://synthesia.io', 'AI avatars|Multilingual|No-code|Professional quality|Script-to-video', 'Training videos|Corporate content|Explainers|Multilingual videos', '👤', 'web'),
('kling', 'Kling AI', 'videos', 'Photoreal human actors with lip-sync', 'Free plan; paid from $5/month', 'https://klingai.com', 'Photorealistic humans|Lip-sync|High quality|Value pricing', 'Human-focused videos|Talking head videos|Marketing|Social content', '🎭', 'web'),
('pika', 'Pictory AI', 'videos', 'Repurpose content into videos', 'Free plan; paid from $19/month', 'https://pictory.ai', 'Blog to video|Highlights|Captions|Voiceovers', 'Content repurposing|Social videos|Video summaries|Marketing clips', '🎞️', 'web'),
('descript', 'Descript', 'videos', 'Text-based video editing', 'Free plan; paid from $12/month', 'https://descript.com', 'Text-based editing|Overdub|Transcription|Podcasting|Video editing', 'Podcasts|Video editing|Transcription|Content creation', '📝', 'desktop,web'),
('capcut', 'CapCut', 'videos', 'Mobile-first video editing', 'Free with Pro options', 'https://capcut.com', 'Mobile editing|Templates|Effects|Easy to use|TikTok integration', 'Social media|Mobile editing|Quick edits|TikTok content', '✂️', 'mobile,desktop'),
('davinci', 'DaVinci Resolve', 'videos', 'Professional video editing', 'Free; Studio $295 one-time', 'https://blackmagicdesign.com/products/davinciresolve', 'Professional editing|Color grading|Audio post|VFX|Free tier', 'Professional editing|Color grading|Film production|Post-production', '🎬', 'desktop'),
('videoleap', 'Video Leap', 'videos', 'Mobile video editing with AI', 'Free; Pro from $7.99/month', 'https://videoleapapp.com', 'Mobile editing|AI effects|Templates|Easy to use', 'Mobile editing|Social content|Quick edits|Creative effects', '📱', 'mobile'),
('shotcut', 'Shotcut', 'videos', 'Free open-source video editor', 'Free', 'https://shotcut.org', 'Open-source|Free|Cross-platform|No watermarks', 'Free editing|Basic projects|Learning|Open-source needs', '🎬', 'desktop'),
('reccloud', 'RecCloud', 'videos', 'Screen recording and editing', 'Free; paid from $9.95/month', 'https://reccloud.com', 'Screen recording|Cloud storage|Easy editing|Collaboration', 'Screen recordings|Tutorials|Presentations|Team collaboration', '☁️', 'web'),
('fliki', 'Fliki', 'videos', 'Text-to-video with AI voices', 'Free; paid from $8/month', 'https://fliki.ai', 'Text to video|AI voices|Templates|Easy creation', 'Social videos|Marketing|Explanations|Quick content', '🎙️', 'web'),
('supercreator', 'SuperCreator', 'videos', 'Short-form video creation', 'Pricing on request', 'https://supercreator.ai', 'Short videos|AI generation|Mobile-first|Quick creation', 'TikTok|Reels|Shorts|Social media', '⚡', 'mobile'),
('lucyedit', 'lucyedit.ai', 'videos', 'AI video editing assistant', 'Pricing varies', 'https://lucyedit.ai', 'AI editing assistant|Automation|Smart cuts|Efficient workflow', 'Video editing|Content creation|Automated editing|Efficient production', '🤖', 'web'),
('akuma', 'akuma.ai', 'videos', 'AI anime video generation', 'Pricing varies', 'https://akuma.ai', 'Anime generation|Style control|Character consistency|Creative anime', 'Anime content|Animation|Creative videos|Stylized content', '👾', 'web'),
('animebuilder', 'animebuilder.ai', 'videos', 'Anime character and video creation', 'Pricing varies', 'https://animebuilder.ai', 'Anime characters|Video creation|Style options|Character builder', 'Anime projects|Character design|Animation|Creative content', '🎨', 'web'),
('higgsfield', 'Higgsfield FaceSwap', 'videos', 'AI face swapping for videos', 'Free with premium options', 'https://higgsfield.ai', 'Face swapping|Video manipulation|High quality|Easy to use', 'Entertainment|Creative edits|Social content|Face replacement', '😄', 'web,mobile');

-- Insert Voice/Audio Tools
INSERT INTO tools VALUES
('elevenlabs', 'ElevenLabs', 'voice', 'Overall realism and voice cloning', 'Free plan; paid from $5/month', 'https://elevenlabs.io', 'Highly realistic voices|Voice cloning|Emotional control|Natural-sounding', 'Voiceovers|Audiobooks|Content creation|Voice cloning', '🎙️', 'web,api'),
('murf', 'Murf AI', 'voice', 'Voiceovers with emphasis control', 'Free plan; paid from $19/month', 'https://murf.ai', 'Wide voice range|Emphasis control|Video integration|Professional quality', 'Voiceovers|Presentations|E-learning|Marketing videos', '🗣️', 'web'),
('wellsaid', 'WellSaid Labs', 'voice', 'Enterprise collaboration and consistency', 'Custom pricing', 'https://wellsaidlabs.com', 'Enterprise-grade|Consistent quality|Brand-specific|Collaboration tools', 'Enterprise content|Brand voice|Professional voiceovers|Team projects', '💼', 'web'),
('krisp', 'Krisp', 'voice', 'Noise cancellation and voice clarity', 'Free; Pro $8/month', 'https://krisp.ai', 'Noise cancellation|Background removal|Voice clarity|Meeting enhancement', 'Video calls|Podcasts|Recording|Professional audio', '🔇', 'desktop,mobile'),
('altered', 'Altered', 'voice', 'Voice changing and editing', 'Free; paid from $29/month', 'https://altered.ai', 'Voice changing|Real-time|Multiple voices|Professional quality', 'Voice acting|Content creation|Character voices|Creative projects', '🎭', 'desktop'),
('voicemod', 'Voicemod', 'voice', 'Real-time voice changing', 'Free with Pro options', 'https://voicemod.net', 'Real-time voice change|Gaming|Streaming|Entertainment', 'Gaming|Streaming|Discord|Entertainment', '🎮', 'desktop'),
('sonic3', 'Sonic-3', 'voice', 'Advanced voice synthesis', 'Pricing varies', 'https://sonic-3.ai', 'Advanced synthesis|High quality|Natural voices|Fast generation', 'Voiceovers|Content creation|Professional audio|Synthesis', '🔊', 'api');

-- Insert Productivity Tools
INSERT INTO tools VALUES
('notion', 'Notion AI', 'productivity', 'Note-taking with AI assistance', 'Free; Plus $10/month, AI add-on $8/user/month', 'https://notion.so', 'Note organization|AI writing|Summarization|Knowledge management', 'Documentation|Project management|Knowledge base|Team collaboration', '📝', 'web,mobile,desktop'),
('copilot_ms', 'Microsoft Copilot', 'productivity', 'Microsoft 365 integration', 'Included with Microsoft 365', 'https://microsoft.com/microsoft-copilot', 'Office integration|Smart summaries|Email assistance|Daily work automation', 'Office work|Email|Excel|Document creation', '🔷', 'web,desktop'),
('taskade', 'Taskade', 'productivity', 'AI-powered task management', 'Free; paid from $8/month', 'https://taskade.com', 'Task management|AI workflows|Team collaboration|Multiple views', 'Project management|Team tasks|Workflows|Planning', '✓', 'web,mobile,desktop'),
('meetgeek', 'MeetGeek', 'productivity', 'Meeting transcription and summaries', 'Free; paid from $15/month', 'https://meetgeek.ai', 'Meeting transcription|AI summaries|Action items|Integration', 'Meeting notes|Team sync|Documentation|Follow-ups', '🤝', 'web'),
('fireflies', 'Fireflies.ai', 'productivity', 'Meeting notes on autopilot', 'Free; paid from $10/user/month', 'https://fireflies.ai', 'Auto transcripts|Summaries|Search|CRM integration', 'Meeting notes|Highlights|Search|Team collaboration', '🔥', 'web'),
('albus', 'Albus', 'productivity', 'AI assistant for teams', 'Pricing varies', 'https://albus.org', 'Team assistant|Quick answers|Knowledge base|Slack integration', 'Team questions|Knowledge sharing|Quick help|Slack workflows', '🧙', 'web'),
('slides_ai', 'Slides AI', 'productivity', 'AI presentation creation', 'Free; paid from $10/month', 'https://slidesai.io', 'Auto presentations|AI content|Professional design|Quick creation', 'Presentations|Pitch decks|Reports|Education', '📊', 'web'),
('tome', 'Tome AI', 'productivity', 'AI-made presentations', 'Free; paid from $10/month', 'https://tome.app', 'AI decks|Mobile-ready|Fast creation|Sleek design', 'Presentations|Pitch decks|Storytelling|Quick slides', '💎', 'web'),
('gamma', 'Gamma', 'productivity', 'AI presentation and document creation', 'Free; paid from $10/month', 'https://gamma.app', 'AI presentations|Documents|Websites|Beautiful design', 'Presentations|Documents|Pitch decks|Marketing', '⚡', 'web'),
('beautiful', 'Beautiful.ai', 'productivity', 'Smart presentation design', 'Free trial; from $12/month', 'https://beautiful.ai', 'Smart templates|Auto-design|Team collaboration|Brand consistency', 'Business presentations|Pitch decks|Reports|Professional slides', '🎨', 'web'),
('creati', 'Creati AI', 'productivity', 'AI-powered creative workspace', 'Pricing varies', 'https://creati.ai', 'Creative workspace|AI assistance|Collaboration|Multi-purpose', 'Creative projects|Team work|Design|Content creation', '🎨', 'web');

-- Insert Coding Tools
INSERT INTO tools VALUES
('github_copilot', 'GitHub Copilot', 'coding', 'AI pair programming', 'Individual $10/month, Business $19/user/month', 'https://github.com/features/copilot', 'Code completion|IDE integration|Context-aware|Multi-language', 'Code writing|Debugging|Learning|Productivity', '🤖', 'ide'),
('copilot_x', 'Copilot X', 'coding', 'Next-gen AI coding assistant', 'Included with GitHub Copilot', 'https://github.com/features/copilot', 'Advanced AI|Chat interface|PR analysis|Documentation', 'Code review|Documentation|Complex coding|Learning', '⚡', 'ide'),
('askcodi', 'AskCodi', 'coding', 'Multi-language coding assistant', 'Free; paid from $9.99/month', 'https://askcodi.com', 'Multiple languages|Code generation|Explanations|IDE integration', 'Code generation|Learning|Debugging|Documentation', '💻', 'web,ide'),
('code_whisperer', 'AWS Code Whisperer', 'coding', 'AWS-optimized coding', 'Free for individuals', 'https://aws.amazon.com/codewhisperer/', 'AWS optimization|Security scanning|Free tier|IDE integration', 'AWS development|Cloud coding|Security|Cost optimization', '☁️', 'ide'),
('autoregex', 'AutoRegex', 'coding', 'AI regex generation', 'Free', 'https://autoregex.xyz', 'Regex generation|Natural language|Testing|Explanations', 'Regex creation|Pattern matching|Text processing|Learning', '🔍', 'web'),
('lightning_ai', 'Lightning AI', 'coding', 'AI for ML development', 'Free; cloud credits vary', 'https://lightning.ai', 'ML development|PyTorch Lightning|Cloud compute|Collaboration', 'Machine learning|AI models|Research|Model training', '⚡', 'web,api'),
('jupyter_ai', 'Jupyter AI', 'coding', 'AI in Jupyter notebooks', 'Free (open-source)', 'https://jupyter.ai', 'Notebook integration|Code generation|Data analysis|Open-source', 'Data science|Analysis|Research|Education', '📓', 'jupyter'),
('deepsek', 'DeepSeek', 'coding', 'Code generation and tech writing', 'Free plan; pay-as-you-go', 'https://deepseek.com', 'Code generation|Summaries|Technical writing|Fast', 'Coding help|Documentation|Fact-checking|Technical content', '🔎', 'web,api');

-- Insert Automation Tools
INSERT INTO tools VALUES
('zapier', 'Zapier', 'automation', 'Workflow automation', 'Free; paid from $19.99/month', 'https://zapier.com', 'App integration|No-code|5000+ apps|Automation workflows', 'App automation|Workflow automation|Integration|Productivity', '⚡', 'web'),
('make', 'Make', 'automation', 'Visual automation platform', 'Free; paid from $9/month', 'https://make.com', 'Visual builder|Complex workflows|API integration|Powerful automation', 'Complex automation|API workflows|Data processing|Integration', '🔧', 'web'),
('n8n', 'n8n', 'automation', 'Open-source workflow automation', 'Free (self-hosted); cloud from $20/month', 'https://n8n.io', 'Open-source|Self-hosted option|Flexible|Developer-friendly', 'Custom automation|Self-hosted|Development|Complex workflows', '🔗', 'web,self-hosted'),
('bardeen', 'Bardeen', 'automation', 'Browser automation', 'Free; paid from $10/month', 'https://bardeen.ai', 'Browser automation|No-code|AI-powered|Quick automation', 'Web scraping|Browser tasks|Data extraction|Productivity', '🎯', 'browser');

-- Insert Employment Tools
INSERT INTO tools VALUES
('simpleapply', 'SimpleApply.io', 'employment', 'Automated job applications', 'Pricing varies', 'https://simpleapply.io', 'Auto applications|Job matching|Time-saving|Multiple platforms', 'Job search|Applications|Career hunting|Time efficiency', '💼', 'web'),
('typeless', 'Typeless', 'employment', 'AI resume and cover letter writing', 'Pricing varies', 'https://typeless.app', 'Resume writing|Cover letters|AI optimization|ATS-friendly', 'Resume creation|Job applications|Career documents|Optimization', '📄', 'web'),
('fellou', 'Fellou', 'employment', 'AI career assistant', 'Pricing varies', 'https://fellou.ai', 'Career guidance|Job matching|Resume help|Interview prep', 'Career planning|Job search|Interview prep|Career development', '🎯', 'web'),
('jack_and_jill', 'Jack And Jill', 'employment', 'AI job search assistant', 'Pricing varies', 'https://jackandjill.ai', 'Job search|Application tracking|AI matching|Career support', 'Job hunting|Application management|Career search|Tracking', '🔍', 'web');

-- Insert Browser Tools
INSERT INTO tools VALUES
('chatgpt_atlas', 'ChatGPT Atlas', 'browser', 'Browser integration for ChatGPT', 'Extension pricing varies', 'https://openai.com', 'Browser integration|Quick access|Context awareness|Productivity', 'Quick AI access|Web assistance|Research|Writing help', '🌐', 'browser'),
('perplexity_comet', 'Perplexity Comet', 'browser', 'Research browser extension', 'Extension included with account', 'https://perplexity.ai', 'Research on any page|Quick answers|Citations|Context', 'Web research|Fact-checking|Learning|Quick lookup', '🔍', 'browser');

-- Insert Mixed/Other Tools
INSERT INTO tools VALUES
('venngage', 'Venngage AI', 'mixed', 'Infographics and brand kit', 'Free; paid from $10/month', 'https://venngage.com', 'Infographics|Brand kit|Templates|Visual content', 'Infographics|Marketing|Visual content|Brand materials', '📊', 'web'),
('looka', 'Looka', 'mixed', 'Logo and brand generator', 'From $20 or $96/year', 'https://looka.com', 'Logo generation|Brand kit|Quick branding|Professional', 'Logo design|Branding|Startups|Quick brand identity', '🎨', 'web'),
('jasper', 'Jasper AI', 'mixed', 'Marketing content at scale', 'From $39/month per seat', 'https://jasper.ai', '50+ templates|Brand tone|SEO|Team collaboration', 'Marketing|Blog posts|Ads|Social content', '✍️', 'web'),
('writesonic', 'Writesonic', 'mixed', 'Fast content for ecom and ads', 'Free trial; paid from $16/month', 'https://writesonic.com', '100+ templates|SEO|Citations|Multiple use cases', 'Ecommerce|Ads|Blog posts|Marketing', '✨', 'web'),
('grammarly', 'Grammarly', 'mixed', 'Writing enhancement', 'Free; Premium from $12/month', 'https://grammarly.com', 'Grammar fixes|Tone|Rewrites|Real-time help', 'Writing|Emails|Documents|Communication', '✏️', 'browser,web,desktop'),
('rytr', 'Rytr', 'mixed', 'Quick content generation', 'Free 10K chars; paid $9/month', 'https://rytr.me', '40+ templates|30+ languages|Affordable|Quick', 'Quick drafts|Social media|Short content|Budget option', '⚡', 'web'),
('wordtune', 'Wordtune', 'mixed', 'Writing enhancement and rewriting', 'Free; from $9.99/month', 'https://wordtune.com', 'Smart rewrites|Tone tweaks|Clarity|Context-aware', 'Writing polish|Emails|Documents|Communication', '📝', 'browser,web'),
('sudowrite', 'Sudowrite', 'mixed', 'Creative fiction writing', '$10/month for 225K words', 'https://sudowrite.com', 'Plot builder|Vivid rewrites|Character development|Story focus', 'Fiction|Scripts|Storytelling|Creative writing', '📚', 'web'),
('decktopus', 'Decktopus', 'mixed', 'AI presentation builder', 'Free; paid options', 'https://decktopus.com', 'Quick presentations|Templates|AI content|Easy to use', 'Business presentations|Pitch decks|Reports|Quick slides', '🎴', 'web'),
('imagekit', 'ImageKit.io', 'mixed', 'Image optimization and CDN', 'Free tier; paid from $49/month', 'https://imagekit.io', 'Image CDN|Optimization|Transformation|API|Performance', 'Image delivery|Web performance|Media management|E-commerce', '🖼️', 'api,web'),
('cohesive', 'Cohesive', 'mixed', 'AI content editor', 'Free; paid options', 'https://cohesive.so', 'Content creation|Templates|Collaboration|Multiple formats', 'Content creation|Marketing|Social media|Documents', '✨', 'web'),
('opus_clip', 'Opus Clip', 'mixed', 'Repurpose long videos to shorts', 'Free with watermark; $19/month', 'https://opus.pro', 'Video highlights|Auto-resize|Virality score|Shorts creation', 'Video repurposing|Shorts|Social clips|Content recycling', '✂️', 'web'),
('filmora', 'Filmora', 'mixed', 'Video editing with AI features', 'Free with watermark; from $19.99/month', 'https://filmora.wondershare.com', 'AI scene detection|Templates|Effects|Easy editing', 'Video editing|Casual projects|Social media|Small business', '🎬', 'desktop'),
('adobe_sensai', 'Adobe Sensei', 'mixed', 'AI across Adobe products', 'Included in Adobe plans', 'https://adobe.com', 'Auto-edits|Tagging|Personalization|Cross-product AI', 'Adobe workflows|Professional editing|Automation|Creative work', '🔷', 'adobe'),
('airtable', 'Airtable AI', 'mixed', 'Database with AI features', 'Free; paid from $20/user/month', 'https://airtable.com', 'AI formulas|Data ops|Auto content|Smart database', 'Database|Project management|Content ops|Automation', '📊', 'web');

-- Insert Scores for Chat/LLM
INSERT INTO scores VALUES
-- Writing scores
('writing', 'chatgpt', 9), ('writing', 'claude', 7.5), ('writing', 'grok', 6), ('writing', 'gemini', 5),
-- Research scores
('research', 'perplexity', 9), ('research', 'claude', 7.5), ('research', 'gemini', 4.5), ('research', 'chatgpt', 4),
-- Coding scores
('coding', 'chatgpt', 9), ('coding', 'claude', 7.5), ('coding', 'github_copilot', 9), ('coding', 'gemini', 5), ('coding', 'deepsek', 7),
-- Analysis scores
('analysis', 'claude', 9), ('analysis', 'gemini', 7.5), ('analysis', 'chatgpt', 4.5), ('analysis', 'perplexity', 6),
-- Collaboration scores
('collaboration', 'gemini', 9), ('collaboration', 'chatgpt', 4.5), ('collaboration', 'notion', 7), ('collaboration', 'copilot_ms', 7),
-- Trends scores
('trends', 'grok', 9), ('trends', 'perplexity', 7.5), ('trends', 'gemini', 4.5);

-- Insert Scores for Images
INSERT INTO scores VALUES
('images', 'midjourney', 9), ('images', 'dalle3', 8), ('images', 'firefly', 8), 
('images', 'stable_diffusion', 7), ('images', 'canva_magic', 6), ('images', 'dreamina', 6);

-- Insert Scores for Videos
INSERT INTO scores VALUES
('videos', 'sora', 9), ('videos', 'veo', 8.5), ('videos', 'runway', 8), 
('videos', 'synthesia', 7), ('videos', 'kling', 7.5), ('videos', 'capcut', 6),
('videos', 'davinci', 8), ('videos', 'descript', 7);

-- Insert Scores for Voice/Audio
INSERT INTO scores VALUES
('voice', 'elevenlabs', 9), ('voice', 'murf', 7.5), ('voice', 'wellsaid', 7),
('voice', 'krisp', 6), ('voice', 'altered', 6.5), ('voice', 'sonic3', 7);

-- Insert Scores for Productivity
INSERT INTO scores VALUES
('productivity', 'notion', 8), ('productivity', 'copilot_ms', 7.5), ('productivity', 'taskade', 6),
('productivity', 'meetgeek', 7), ('productivity', 'tome', 7), ('productivity', 'gamma', 7.5);

-- Insert Scores for Automation
INSERT INTO scores VALUES
('automation', 'zapier', 9), ('automation', 'make', 8.5), ('automation', 'n8n', 8),
('automation', 'bardeen', 7);

-- Insert Scores for Employment
INSERT INTO scores VALUES
('employment', 'simpleapply', 7), ('employment', 'typeless', 6.5), 
('employment', 'fellou', 6), ('employment', 'jack_and_jill', 6);

-- Insert Scores for Browser Tools
INSERT INTO scores VALUES
('browser', 'chatgpt_atlas', 7), ('browser', 'perplexity_comet', 7.5), 
('browser', 'grammarly', 8), ('browser', 'bardeen', 6);

-- Insert Scores for Mixed Scenarios
INSERT INTO scores VALUES
('mixed', 'chatgpt', 8), ('mixed', 'claude', 7.5), ('mixed', 'jasper', 7),
('mixed', 'writesonic', 6.5), ('mixed', 'notion', 7), ('mixed', 'canva_magic', 7)