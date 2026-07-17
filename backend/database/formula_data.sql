-- ============================================================
-- 方剂数据导入
-- 来源: 标注二级分类后的方剂表.xlsx
-- ============================================================

USE tcm_hospital;

-- 清空已有数据
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE formula_herb;
TRUNCATE TABLE formula;
SET FOREIGN_KEY_CHECKS = 1;

-- 插入方剂数据
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('九仙散', '经典方剂', '固涩剂', '敛肺止咳，益气养阴。', '久咳伤肺，气阴两伤证。咳嗽日久不已，咳甚则气喘自汗，痰少而黏，脉虚数。', '若虚热明显，可加地骨皮、麦冬、玄参以加强润肺清热之功。', '王子昭方，录自《卫生宝鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('桃花汤', '经典方剂', '固涩剂', '涩肠止痢，温中散寒。', '虚寒痢。下痢不止，或滑脱不禁，便脓血，色暗，腹痛喜温喜按，舌淡苔白，脉迟弱或微细。', '若阳虚阴寒较盛者，加附子、肉桂温肾暖脾以散阴寒;腹痛甚者，加当归、白芍养血柔肝以止痛;久泻滑脱不禁者，加党参、煨肉豆蔻以益气涩肠固脱。', '伤寒论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('桑螵蛸散', '经典方剂', '固涩剂', '调补心肾，固精止遗。', '心肾两虚之尿频或遗尿、遗精证。小便频数，或尿如米泔色，或遗尿，或滑精，心神恍惚，健忘，舌淡苔白，脉细弱。', '方中加入益智仁、覆盆子等，可增强涩精缩尿止遗之力。若健忘心悸者，可加酸枣仁、五味子以养心安神；兼有遗精者，可加沙苑子、山萸肉以固肾涩精。', '本草衍义');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('真人养脏汤（原名纯阳真人养脏汤）', '经典方剂', '固涩剂', '涩肠固脱，温补脾肾。', '久泻久痢、脾肾虚寒证。大便滑脱不禁，甚则脱肛坠下，腹痛喜温喜按，或下痢赤白，或便脓血，里急后重，日夜无度，不思饮食，舌淡苔白，脉沉迟细。', '脾肾虚寒、手足不温者，可加附子以温肾暖脾；脱肛坠下者，加升麻、黄芪以益气升陷。', '太平惠民和剂局方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('缩泉丸（原名固真丹）', '经典方剂', '固涩剂', '温肾祛寒，缩尿止遗。', '膀胱虚寒证。小便频数，或遗尿不禁，舌淡，脉沉弱。', '肾精亏虚者，酌加山药、熟地以补益肾精。天台乌药与益智仁用量相同，需注重其用量。', '魏氏家藏方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('赤石脂禹余粮汤', '经典方剂', '固涩剂', '收敛涩肠止泻。', '下利不止，滑脱不禁，脉沉细无力。', '若便血夹杂粘液白冻，加阿胶、干姜、黄芩；气虚，加黄芪、党参、白术；虚寒性月经过多和便血，加补骨脂、炒乌梅；肾阳虚见腰膝酸软，形寒肢冷者，加补骨脂、吴茱萸、肉豆蔻。', '伤寒论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('金锁固精丸', '经典方剂', '固涩剂', '补肾涩精。', '肾虚不固之遗精。遗精滑泄，腰疼耳鸣，四肢酸软，神疲乏力，舌淡苔白，脉细弱。', '若大便干结者，可加熟地、肉苁蓉以补精血而通大便；大便溏泄者，加补骨脂、菟丝子、五味子以补肾固涩；腰膝酸痛者，加杜仲、续断以补肾而壮腰膝；兼见阳痿者，加锁阳、淫羊藿以补肾壮阳。', '医方集解');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('龙骨散', '经典方剂', '固涩剂', '燥湿敛疮。', '脐疮；脐湿。', '若局部红肿热痛者，按脐疮处理。', '杂病源流犀烛');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('交济汤', '经典方剂', '安神剂', '补益心肾', '闻妇女之声而淫精自出，亦脱症之渐也。', '心气虚者，可加远志、茯神以益心气安神；肾水不足者，可加莲子、山药以滋肾水。', '辨证录');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('养心汤', '经典方剂', '安神剂', '补益气血，养心安神。', '气血不足，心神不宁证。神思恍惚，心悸易惊，失眠健忘，舌淡苔白，脉细弱。', '若兼心烦口渴、手足心热者，可加生地、麦冬、枸杞子等以增强滋阴养血之力；若善悲欲哭，忧愁抑郁者，可加合欢皮、白芍、郁金等以柔肝解郁；如水饮内停、怔忡心悸者，加槟榔、茯苓。', '仁斋直指方论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('天王补心丹', '经典方剂', '安神剂', '滋阴养血，补心安神。', '阴虚血少，神志不安证。心悸怔忡，虚烦失眠，神疲健忘，或梦遗，手足心热，口舌生疮，大便干结，舌红少苔，脉细数。', '失眠重者，可酌加龙骨、磁石以重镇安神；心悸怔忡甚者，可酌加龙眼肉、夜交藤以增强养心安神之功；遗精者，可酌加金樱子、煅牡蛎以固肾涩精。', '校注妇人良方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('安神定志灵', '经典方剂', '安神剂', '清心平肝，豁痰开窍，安神定志。', '心肝火旺证。小儿多动症，抽动症。', '急躁易怒者，加钩藤、珍珠母；冲动任性，烦躁不安者，加栀子、青礞石；大便干结，数日一行者，加大黄、枳实、槟榔。', '儿童多动症临床治疗学');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('定志丸', '经典方剂', '安神剂', '补心强志，开窍明目。', '目不能远视，而能近视者。常服益心强志，能疗健忘。', '若食欲不振者，加麦芽、山楂以健胃消食；心悸重者，加五味子、酸枣仁、柏子仁以养心安神；神倦乏力者，可加白术、黄芪、大枣以健脾益气。', '审视瑶函');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('桂枝甘草龙骨牡蛎汤', '经典方剂', '安神剂', '潜镇安神，温通心阳。', '心阳虚损，神志不安证。心悸怔忡，失眠多梦，烦躁不安，面色㿠白，舌质淡胖嫩，苔白滑，脉弱；或见胸闷气短，畏寒肢冷，自汗乏力，面唇青紫，舌质紫暗，脉结或代等。', '若见失眠，加石菖蒲、酸枣仁、远志以安心神；气虚，加党参、黄芪以补气；寒甚，加重桂枝量，也可酌加干姜、熟附子；伴阴虚者，酌加生地、麦冬以滋阴。', '伤寒论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('珍珠母丸（原名真珠丸）', '经典方剂', '安神剂', '镇心安神，平肝潜阳，滋阴养血。', '心肝阳亢，阴血不足，神志不宁证。入夜少寐，时而惊悸，头目眩晕，脉细弦。', '失眠者，加远志、石菖蒲以安心神。心血亏虚者，重用酸枣仁，酌加龙眼肉。', '普济本事方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('琥珀养心丹', '经典方剂', '安神剂', '养心安神,清热除惊', '心血亏虚，惊悸怔忡，夜卧不宁，心烦口干，失眠健忘，善惊易恐，舌质淡红，脉细数等。', '痰火未平，舌苔黄腻，加胆南星、天竺黄；心火亢盛者，加朱砂安神丸；睡不安稳者，加孔圣枕中丹。', '证治汇补');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('甘麦大枣汤', '经典方剂', '安神剂', '养心安神，和中缓急。', '脏躁。精神恍惚，常悲伤欲哭，不能自主，心中烦乱， 睡眠不安，甚则言行失常，呵欠频作，舌淡红苔少，脉细略数。', '见阵发性身热、面赤、汗出，可加麦冬以养心止汗；心烦不眠，可加百合、酸枣仁以养肝宁心；呵欠频作属于心肾两虚者，可加山萸肉、党参以补养心肾。', '金匮要略');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('菖蒲丸', '经典方剂', '安神剂', '补心养血。', '心气不足证。面色苍白，智力低下，神情呆钝，语言发育迟缓。舌淡，脉细弱。', '头发稀疏萎黄者，加何首乌、肉苁蓉；食欲不佳者，加焦山楂、鸡内金。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('黄连阿胶汤', '经典方剂', '安神剂', '滋阴降火，除烦安神。', '阴虚火旺，心肾不交证。心中烦热，失眠不得卧，口燥咽干，舌红苔少，脉细数。', '若肾阴虚甚者，可加枸杞子、女贞子以育阴滋肾；若心胸烦热较甚者，加栀子、竹叶以清心火；如大便干者，加麻仁、麦冬以滋阴润燥生津；若失眠甚者，加酸枣仁、柏子仁以滋补阴血安神；不寐多梦者，加茯神、菖蒲、远志以交通心肾、宁心安神。', '伤寒论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('安宫牛黄丸', '经典方剂', '开窍剂', '清热解毒，豁痰开窍。', '邪热内陷心包证。高热烦躁，神昏谵语，或舌謇肢厥，舌红或绛，脉数。亦治中风昏迷，小儿惊厥，属邪热内闭者。', '若温病初起，邪在肺卫，迅即逆传心包者，可用金银花、薄荷或银翘散加减煎汤送服本方，以增强清热透解的作用；若邪陷心包，兼有腑实，症见神昏舌短、大便秘结、饮不解渴者，宜开窍与攻下并用，以安宫牛黄丸2粒化开，调生大黄末9克内服，先服一半，不效再服；热闭证见脉虚，有内闭外脱之势，急宜人参煎汤送服本方。', '温病条辨');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('抱龙丸', '经典方剂', '开窍剂', '清热化痰，开窍醒神。', '小儿急惊，痰热闭窍之证。身热昏睡，痰盛气粗，发惊发厥，四肢抽搐。', '若兼见表证不解，发热恶风，口渴思饮者，可用荆芥、薄荷、防风，煎汤送服本药，以疏风解表，退热止痉；若痰热内盛，咳喘气壅者加服羚羊清肺丸，以加强化痰止咳平喘之效；若昏迷抽搐较甚者，可选用牛黄清心丸或紫雪以加强清心开窍之效；若为体弱病儿罹患此病需用本药时，当与人参生脉饮同用以扶正祛邪。', '小儿药证直诀');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('牛黄清心丸', '经典方剂', '开窍剂', '清热解毒，开窍安神。', '温邪内陷，热入心包，身热烦躁，神昏妄语，中风痰热内闭，神昏语謇，及小儿惊风，发热抽搐。', '若昏迷痰多者，加菖蒲、胆南星、竹沥；高热神昏抽搐者，可选加紫雪丹、安宫牛黄丸和至宝丹。', '痘疹世医心法');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('白金丸', '经典方剂', '开窍剂', '豁痰通窍，清心安神。', '用于痰气壅塞，癫痫发狂，猝然昏倒，口吐涎沫。', '无。', '外科全生集');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('至宝丹', '经典方剂', '开窍剂', '清热开窍，化浊解毒。', '痰热内闭心包证。神昏谵语，身热烦躁，痰盛气粗，舌绛苔黄垢腻，脉滑数。亦治中风、中暑、小儿惊厥属于痰热内闭者。', '若湿热酿痰，蒙蔽心包，热邪与痰浊并重，症见身热不退、朝轻暮重、神识昏蒙、舌绛苔黄浊者，可用《温病全书》菖蒲郁金汤（石菖蒲、炒栀子、鲜竹叶、牡丹皮、郁金、连翘、灯心、木通、淡竹茹、紫金片）煎汤送服本方，以清热利湿、化痰开窍。如有内闭外脱之势，急宜人参煎汤送服本方。', '灵苑方》引郑感方，录自《苏沈良方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('人参五味子汤', '经典方剂', '治燥剂', '健脾益气。', '久嗽脾虚，中气怯弱，面白唇白者。', '咳嗽痰多者，去五味子，加半夏、陈皮、杏仁；咳嗽重者，加紫菀、款冬花；动则汗出重者，加黄芪、龙骨、牡蛎；汗出不温者，加桂枝、白芍；食欲不振者，加山楂、神曲、麦芽；常有喷嚏流涕者，加辛夷、乌梅、白芍；咽痒者，加蝉蜕、僵蚕；痰多者，加浙贝母；腹胀者，加莱菔子、枳壳、槟榔；便溏者，加怀山药、炒扁豆；大便不实者，加白扁豆、山药；盗汗甚者，加地骨皮、浮小麦、牡蛎；大便干结者，加火麻仁、瓜蒌。', '幼幼集成');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('养金汤', '经典方剂', '治燥剂', '润肺清火。', '水涸火炎，肺金受克，咽喉燥痛。', '可加百部杀痨虫；时有咯血者，加侧柏叶、茜草根、藕节以敛血止血。', '类证治裁');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('甘露饮', '经典方剂', '治燥剂', '滋阴增液，清心降火。', '口舌生疮，牙宣心热。', '心火亢盛者，可加木通、竹叶以清心火。', '普济方》卷二九九引《如宜方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('艾附暖宫丸', '经典方剂', '温里剂', '理气补血，暖宫调经。', '血虚气滞、下焦虚寒所致的月经不调、痛经，症见行经后错、经量少、有血块、小腹疼痛、经行小腹冷痛喜热、腰膝酸痛。', '下焦虚寒者，酌加附片、干姜以温阳散寒。', '中国药典');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('旋覆代赭汤', '经典方剂', '理气剂', '降逆化痰，益气和胃。', '胃虚气逆痰阻证。心下痞硬，噫气不除，或见纳差、呃逆、恶心，甚或呕吐，舌苔白腻，脉缓或滑。', '若胃气不虚者，可去人参、大枣，加重代赭石用量，以增重镇降逆之效；痰多者，加茯苓、陈皮、白术以燥湿化痰和胃。', '伤寒论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('三妙丸', '经典方剂', '祛湿剂', '燥湿清热，消肿止痛。', '治湿热下流，两脚麻木，或如火烙之热。', '便秘者，加生大黄；肺阴虚者，加沙参、麦冬；脾虚者，加白术、山药、扁豆；肾虚者，加龟板、玄参，生地黄改熟地黄。', '医学正传');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('不换金正气散', '经典方剂', '祛湿剂', '祛湿健胃，化痰行滞。', '伤寒瘟疫，时气感冒，霍乱吐泻，寒热往来，痰虐食积，头痛壮热，腰背拘急，脾胃不和，脏腑虚寒虚热，下痢赤白，山岚瘴气。', '脾虚纳呆者，加白术、神曲；寒积内停、腹痛、痢下不爽者，加大黄、槟榔，配炮姜、肉桂；脘腹胀满者，加木香、枳实、莱菔子；暑湿困阻者，加荷叶、扁豆花；大便偏干者，加枳实、莱菔子；大便偏稀者，加泽泻、薏苡仁、山药。', '太平惠民和剂局方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('中焦宣痹汤', '经典方剂', '祛湿剂', '清化湿热，宣痹通络。', '湿热痹证。湿聚热蒸，阻于经络，寒战发热，骨节烦疼，面色痿黄，小便短赤，舌苔黄腻或灰滞，面目痿黄。', '胸闷气憋者，加瓜蒌皮、薤白；肢体酸痛者，加羌活、木瓜；心悸、脉结代者，加丹参、珍珠母。', '温病条辨');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('二妙丸', '经典方剂', '祛湿剂', '清热燥湿。', '湿热下注、腿膝疼痛、脚气肿痛、湿疮以及带下、淋痛等病症。', '湿热痿证，可加豨莶草、木瓜、萆薢以祛湿热；湿热脚气者，宜加薏苡仁、木瓜、槟榔以渗湿降浊；下部湿疹者，可加赤小豆、土茯苓以清湿热解毒。', '丹溪心法');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('二妙散', '经典方剂', '祛湿剂', '清热燥湿。', '湿热下注证。筋骨疼痛，或两足痿软，或足膝红肿疼痛，或湿热带下，或下部湿疮，小便短赤，舌苔黄腻。', '若为湿热痿证，可加豨莶草、木瓜、萆薢以祛湿热强筋骨；湿热脚气者，宜加木瓜、薏苡仁、槟榔等以渗湿降浊；下部湿疮、湿疹，可加赤小豆、土茯苓清湿热，解疮毒。', '丹溪心法');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('二陈平胃散', '经典方剂', '祛湿剂', '消积宽中，化痰止咳。', '主食积咳嗽；五更为甚，胸脘满闷，脉沉滑者。', '若痰湿盛而胀满甚，加枳实、紫苏梗、桔梗；气逆不降，嗳气不止者，加旋覆花、代赭石、枳实、沉香；痰湿郁久化热而口苦、舌苔黄者，改用黄连温胆汤；嘈杂不舒，苔黄腻，脉滑数，改用大黄黄连泻心汤合连朴饮；兼脾胃虚弱者加党参、白术、砂仁。', '症因脉治');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('五皮饮', '经典方剂', '祛湿剂', '利湿消肿，理气健脾。', '皮水。症见一身悉肿、肢体沉重、心腹胀、上气喘急、小便不利、妊娠水肿、苔白腻、脉沉缓。', '外感风邪，肿甚而喘者，可加麻黄、杏仁、葶苈子；面肿，胸满，不得卧，加苏子、葶苈子；若湿困中焦，脘腹胀满者，加川椒目、大腹皮、干姜。', '华氏中藏经');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('加味五淋散', '经典方剂', '祛湿剂', '清热利水。', '子淋，孕妇小便频数窘涩，点滴疼痛。', '若热毒甚者，酌加金银花、野菊花、蒲公英、紫花地丁清热解毒；若热伤胞络，尿色红赤者，加小蓟、地榆、白茅根、益母草、旱莲草以清热利尿止血；若口舌生疮，心烦者，加竹叶以清心除烦；若小便混浊者，加萆薢、石菖蒲以分清泌浊；若肝经郁热者，加龙胆草、茵陈以清肝泄热；若口渴引饮，舌红少津者，加知母、玉竹、石斛以养阴生津。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('四妙散', '经典方剂', '祛湿剂', '清热利湿，强筋壮骨。', '肝肾不足，湿热下注，致成痿证。', '若小便短赤不利，加栀子、萆薢、车前草；若湿热蕴久，耗伤阴津，加生地黄、知母、女贞子、墨旱莲。', '成方便读');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('散风除湿活血汤', '经典方剂', '祛湿剂', '散风燥湿，活血通络。', '巩膜炎合并风湿。白睛结节，色较鲜红，羞明流泪，视物不清，伴骨节疼痛，肢节肿胀。', '火疳红赤甚者，可去方中部分辛温祛风之品，选加牡丹皮、丹参以凉血活血消瘀，加桑白皮、地骨皮以清泄肺热；若骨节酸痛、肢节肿胀者，可加豨莶草、秦艽、络石藤、海桐皮等以祛风湿、通经络。', '中医眼科临床实践');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('木通散', '经典方剂', '祛湿剂', '理气行滞，行水利尿。', '产后小便不通，小腹胀痛，情志抑郁。苔滑，脉弦。', '小便不通甚者，可加泽泻、猪苓、茯苓利水渗湿，或可加桂枝以助阳化气。', '妇科玉尺');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('栝楼瞿麦丸', '经典方剂', '祛湿剂', '化气，利水，润燥。', '小便不利者，有水气，其人若渴。', '下元亏虚较甚者，加肉桂、益智仁、补骨脂以温肾壮阳；小便不利、水肿尤甚者，可加用桂枝、泽泻、猪苓、生姜等温阳利水；脾气亏虚尤甚者，加白术、党参、黄芪以健脾益气；口渴严重者，加天花粉、山药、芦根、五味子以润燥止渴。', '金匮要略');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('泽泻汤', '经典方剂', '祛湿剂', '利水除饮，健脾制水。', '饮停心下，头目眩晕，胸中痞满，咳逆水肿。', '若脾虚湿蕴者，加党参、茯苓、陈皮、苍术以健脾化湿；若水饮较甚，加车前子、猪苓以利水。', '金匮要略');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('甘姜苓术汤', '经典方剂', '祛湿剂', '祛寒除湿。', '肾著病。身重，腰下冷痛，腰重如带五千钱，饮食如故，口不渴，小便自利，舌淡苔白，脉沉迟或沉缓。', '若寒邪偏胜，加附子、制川乌、细辛；若湿邪偏胜，加苍术、厚朴、薏苡仁。', '金匮要略');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('竹叶泻经汤', '经典方剂', '祛湿剂', '外散风热，内清伏火。', '治眼目涩痛、视物微昏，内臂按之有脓液流出。', '脓液多且黄稠者，可去羌活，加天花粉、漏芦、乳香、没药，以加强清热排脓、祛瘀消滞的作用。', '原机启微');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('羌活续断汤', '经典方剂', '祛湿剂', '祛风胜湿，散寒止痛。', '一切白虎历节风，手足肢节肿痛如锥。', '风湿痹痛较甚者，加独活、威灵仙。', '医统');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('羌活胜湿汤', '经典方剂', '祛湿剂', '祛风胜湿止痛。', '风湿犯表之痹证。肩背痛不可回顾，头痛身重，或腰脊疼痛，难以转侧，苔白，脉浮。', '若湿邪较重，肢体酸楚甚者，可加苍术、细辛以助祛湿通络；郁久化热者，宜加黄芩、黄柏、知母等以清里热。', '脾胃论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('胃苓汤', '经典方剂', '祛湿剂', '祛湿和胃，行气利水。', '脾虚湿胜，致成黄疸，或大便泄泻，小便清涩，不烦不渴。夏秋之间，脾胃伤冷，水谷不分，泄泻如水，以及水肿、腹胀、小便不利者。', '若胸脘痞闷，气滞偏甚者，可酌加佛手、木香、沉香；如尿少，腹胀，苔腻者，可加砂仁、大腹皮、泽泻、车前子；若神倦，便溏，舌质淡者，宜加党参、黄芪、附片、干姜、川椒；若兼胁下刺痛，舌紫，脉涩者，可加延胡索、莪术、丹参、鳖甲等；外感风邪，肿甚而喘者，可加麻黄、杏仁、葶苈子；面肿，胸满，不得卧，加苏子、葶苈子；若湿困中焦，脘腹胀满者，加川椒目、大腹皮、干姜。', '丹溪心法');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('苓桂术甘汤', '经典方剂', '祛湿剂', '温阳化饮，健脾利水。', '中阳不足之痰饮。胸胁支满，目眩心悸，或短气而咳，舌苔白滑，脉弦滑或沉紧。', '咳嗽痰多者，加半夏、陈皮以燥湿化痰；心下痞或腹中有水声者，可加枳实、生姜以消痰散水。', '金匮要略');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('茯苓导水汤', '经典方剂', '祛湿剂', '行气化湿，利水消肿。', '水肿，头面手足遍身肿如烂瓜之状，手按而塌陷，手起应手而高突，喘满倚坐不得息，不能转侧，不能平卧，饮食不下，小便短涩，溺痛如割，大便绝少，虽有亦如黑豆汁。', '腹胀甚者，酌加枳壳、厚朴理气消胀满；喘甚不得卧者，酌加麻黄、葶苈子、杏仁宣肺行水定喘；下肢肿甚者，酌加防己除湿消肿。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('茵陈五苓散', '经典方剂', '祛湿剂', '利湿退黄。', '湿热黄疸，湿重于热，小便不利者。', '若湿阻气机，胸腹痞胀，呕恶纳差等症较著，可加入苍术、厚朴、半夏；纳呆或食欲明显较差者，可加炒谷芽、炒麦芽、鸡内金。', '金匮要略');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('萆薢分清饮（原名萆薢分清散）', '经典方剂', '祛湿剂', '温肾利湿，分清化浊。', '下焦虚寒之膏淋、白浊。小便频数，混浊不清，白如米泔，凝如膏糊，舌淡苔白，脉沉。', '若兼虚寒腹痛者，可加肉桂、小茴香以温中祛寒；久病气虚者，可加黄芪、白术以益气祛湿。', '杨氏家藏方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('薏苡仁汤', '经典方剂', '祛湿剂', '祛风散寒，除湿通络。', '寒湿痹痛。', '若关节肿胀，加萆薢、猪苓；若肌肤不仁，加海桐皮、豨莶草；若小便不利、肢体浮肿，加茯苓、泽泻、车前子。', '类证治裁');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('藿香正气散', '经典方剂', '祛湿剂', '解表化湿，理气和中。', '外感风寒，内伤湿滞证。霍乱吐泻，恶寒发热，头痛，胸膈满闷，脘腹疼痛，舌苔白腻，脉浮或濡缓。以及山岚瘴疟等。', '若表邪偏重，寒热无汗者，加香薷以助解表；若气滞兼脘腹胀痛者，加木香、厚朴、延胡索以行气止痛。', '太平惠民和剂局方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('除湿胃苓汤', '经典方剂', '祛湿剂', '清热燥湿。', '主缠腰火丹。水泡大小不等，其色黄白，破烂流水，痛甚。', '脾虚者，可加党参、黄芪益气健脾；瘙痒明显者，加白鲜皮、地肤子以祛湿止痒；发于下肢者，加牛膝、黄柏；水疱大而多者，加土茯苓、萆薢、车前草以利水渗湿。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('香砂平胃散', '经典方剂', '祛湿剂', '消食健胃，行气止痛。', '伤食腹痛。', '大便不通，或泻下不畅、脘腹胀满者，加槟榔、莱菔子；兼感寒邪者，加藿香；食滞化热，大便秘结者，去苍术，加大黄、黄连。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('麻黄连翘赤小豆汤', '经典方剂', '祛湿剂', '宣肺利水，清热渗湿。', '阳黄兼表证，发热恶寒，无汗身痒，周身黄染如橘色，脉浮滑。', '若有表寒者，加羌活、防风；有咳喘者，加葶苈子、桑白皮；有血尿者，加小蓟、白茅根；属腰以下肿明显者，加大腹皮；如脓肿毒甚者，当重用蒲公英、紫花地丁；湿盛糜烂者，加苦参、茯苓；皮肤瘙痒者，加白鲜皮、地肤子、蝉衣；疮疡色红肿痛者，加丹皮、赤芍；大便不通，加大黄、芒硝。', '金匮要略');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('一贯煎', '经典方剂', '补益剂', '滋阴疏肝。', '肝肾阴虚，肝气郁滞证。胸脘胁痛，吞酸吐苦，咽干口燥，舌红少津，脉细弱或虚弦。亦治疝气瘕聚。', '若大便秘结，加瓜蒌仁；有虚热或汗多，加地骨皮；痰多，加川贝母；舌红而干，阴亏过甚，加石斛；胁胀痛，按之硬，加鳖甲；烦热而渴，加知母、石膏；腹痛，加芍药、甘草；两足痿软，加牛膝、薏仁；不寐，加酸枣仁；口苦燥，少加黄连。', '续名医类案');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('七味白术散', '经典方剂', '补益剂', '健脾益气，和胃生津。', '脾胃虚弱，津虚内热证。呕吐泄泻，肌热烦渴。', '纳呆、舌苔腻者，加苍术、陈皮、焦山楂；肢冷倦怠、大便清稀不化者，加炮姜、煨益智仁；久泻不止者，加肉豆蔻、石榴皮；肺中燥热者，加地骨皮、知母、黄芩；口渴明显者，加天花粉、生地黄、乌梅；气短、汗多者，合生脉散；食少腹胀者，加砂仁、鸡内金。', '小儿药证直诀');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('七味都气丸', '经典方剂', '补益剂', '滋肾纳气。', '肾阴不足，肺气亏虚所致的虚咳气喘，腰膝酸软，眩晕耳鸣，口燥咽干，烦热盗汗，遗精，小便频数，舌红少津，脉细数。', '阳虚甚，酌加附片、肉桂、补骨脂、仙灵脾、鹿角片；阴虚甚，加生地黄、冬虫夏草；若肾失潜纳，气不归原，加蛤蚧、胡桃肉、沉香。', '医宗己任篇');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('七宝美髯丹', '经典方剂', '补益剂', '补益肝肾，乌发壮骨。', '肝肾不足证。须发早白，脱发，齿牙动摇，腰膝酸软， 梦遗滑精，肾虚不育等。', '若见阳虚者，加巴戟天、仙灵脾以温补肾阳；肝郁者，加郁金、香附以疏肝解郁；阴虚内热者，加丹皮、女贞子、地骨皮、旱莲草以滋阴清热；治脱发，可辅佐桑叶、侧柏叶等外搽；失眠者，加酸枣仁、夜交藤、合欢皮以安心神。', '本草纲目》引《积善堂方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('三仁五子丸', '经典方剂', '补益剂', '益肾填精，补心养血。', '肝肾不足，心血亏虚，视物昏暗，远近内障，干涩昏花。', '眼睛昏花者，加谷精草、木贼以明目。', '杨氏家藏方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('三才封髓丹', '经典方剂', '补益剂', '泻火坚阴，固精封髓。', '用于阴虚火旺、相火妄动、扰动精室之梦遗滑精、失眠多梦、 腰膝酸软、五心烦热、口舌干燥等症。', '如肝火偏旺者，加龙胆草；小溲短赤灼热者，加淡竹叶、灯心草；若遗精频作，潮热颧红，可用大补阴丸。', '卫生宝鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('上下相资汤', '经典方剂', '补益剂', '养阴清热，固冲止血。', '血崩之后，口舌燥裂，不能饮食。', '暴崩下血者，加仙鹤草、海螵蛸涩血止血；淋沥不断者，加茜草、三七化瘀止血；心烦少寐者，加炒酸枣仁、柏子仁养心安神；烘热汗出，眩晕耳鸣者，加龟甲、龙骨育阴潜阳；血久不止，气血亏虚者，加黄芪、枸杞子、当归益气养血。', '石室秘录');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('两地汤', '经典方剂', '补益剂', '滋阴清热。', '肾水不足，虚热内炽，月经先期，量少色红，质稠粘，伴有潮热、盗汗，咽干口燥，舌红苔少，脉细数无力者。', '若正值经期，经血量多色红者，加地榆炭、仙鹤草凉血止血；热灼血瘀，经血有块者，加茜草祛瘀止血；若伴见倦怠乏力者，乃气阴两虚，酌加党参、黄芪、山茱萸气阴双补以止血；咽干口渴，加麦冬、石斛养阴生津；若阴虚内热重者，可加枸杞子、桑椹滋阴壮水以平抑虚火。', '傅青主女科');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('举元煎', '经典方剂', '补益剂', '益气升提。', '气虚下陷，血崩血脱，亡阳垂危等证。', '若经血量多者，酌加棕榈炭、茜草炭、藕节炭以固涩止血；经行有块或伴下腹痛者，酌加泽兰、益母草、五灵脂以化瘀止血止痛；兼见腰骶冷痛，大便溏薄者，为脾肾双亏，酌加鹿角霜、补骨脂、续断、杜仲炭以温补脾肾，固冲止血。若脾肾同病，兼见腰膝酸痛，头晕耳鸣者，酌加桑寄生、续断、补骨脂、覆盆子以补肾益精，固肾止血；兼见食少纳呆，加砂仁、陈皮以醒脾和胃；久崩不止，症见头昏，乏力，心悸失眠者，酌加何首乌、桑寄生、五味子养心安神；脘腹胀闷者，加黑荆芥、煨木香、枳壳宽中行气。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('二仙汤', '经典方剂', '补益剂', '补肾泻火，调理冲任。', '妇女绝经前后诸证，症见头目昏眩，胸闷心烦，少寐多梦，烘热汗出，焦虑抑郁，腰酸膝软，舌红，脉沉细弦。', '肿块较硬者，加牡蛎、海藻、莪术等；伴有乳头溢液者，加白花蛇舌草、黄芩、蒲公英等；月经不调、腰膝酸软者，加菟丝子、女贞子、益母草等。月经紊乱者，加当归、丹参、香附、郁金等；肿块坚硬者，加莪术、石见穿、蜂房、半枝莲等。', '经验方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('五子衍宗丸', '经典方剂', '补益剂', '填精补髓，疏利肾气。', '肾虚精少，阳瘘早泄，遗精，精冷，余沥不清，久不生育。', '阳虚较甚者，可加肉桂、鹿茸；疲乏无力甚者，加黄芪、西洋参；潮热盗汗甚者，加鳖甲、银柴胡。', '摄生众妙方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('人参养荣汤', '经典方剂', '补益剂', '益气补血。', '脾肺气虚，荣血不足，惊悸健忘，寝汗发热，食少无味，身倦肌瘦，色枯气短，毛发脱落，小便赤涩。', '本方可加丹参、石菖蒲、鸡血藤以活血养血；心悸失眠者可加酸枣仁、柏子仁、首乌藤以养心宁神；若气虚较轻，可将人参改用党参；血虚偏重者可加制何首乌、龙眼肉以养血安神；并可加用枳壳、柴胡等理气之品，以通助补。', '和剂局方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('人参益气汤', '经典方剂', '补益剂', '益气养血，升提清阳。', '气血两虚，清阳下陷，多寐，四肢倦怠。', '血虚甚者，加当归、川芎；清阳下陷者，加柴胡、葛根。', '杂病源流犀烛');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('人参蛤蚧散（原名蛤蚧散）', '经典方剂', '补益剂', '补肺益肾，止咳定喘。', '肺肾气虚，痰热咳喘证。咳嗽气喘，呼多吸少，声音低怯，痰稠色黄，或咳吐脓血，胸中烦热，身体羸瘦，或遍身浮肿，脉浮虚。', '若无阴虚内热，去知母，桑白皮减量；咳吐脓血或痰中带血者，加白茅根、苇茎、薏苡仁、桃仁、瓜瓣；阴虚火旺者，加生地、麦冬以滋阴。', '博济方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('何人饮', '经典方剂', '补益剂', '补气血，截虚疟。', '疟疾久发不止，气血两虚，寒热时作，稍劳即发，面色萎黄，倦怠乏力，食少自汗，形体消瘦，舌淡，脉缓大而虚者。', '若气虚、自汗显著，可加黄芪、浮小麦；若午后或傍晚低热，偏于阴虚、舌质绛红者，可加生地黄、鳖甲、白薇；若胸闷脘痞，大便稀溏，苔浊腻者，则去何首乌，加半夏、草果。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('保元汤', '经典方剂', '补益剂', '益气温阳。', '虚损劳怯，元气不足证。倦怠乏力，少气畏寒；以及小儿痘疮，阳虚顶陷，不能发起灌浆者。', '若伴胸痛较著者，可酌加桂枝、檀香、降香等；心悸频作，发无定时，可酌加生龙骨、牡蛎、醋鳖甲等；若兼肢肿尿少者，可合用防己黄芪汤或五苓散化裁；若心脉瘀阻而心胸疼痛者，酌加郁金、川芎、丹参、三七；若阳虚较甚，形寒肢冷者，加附子、巴戟天、仙茅、仙灵脾、鹿茸。', '博爱心鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('保阴煎', '经典方剂', '补益剂', '滋阴降火，清热凉血。', '阴虚内热，症见带下淋浊，色赤带血，血崩便血，舌红，脉数。', '若津伤口渴者，加天冬、麦冬、南沙参、北沙参等以生津止渴；若兼气短懒言、倦怠乏力者，酌加黄芪、党参、白术以健脾益气；经有血块者，加蒲黄、五灵脂、三七祛瘀止血；若偏于阴虚者，治宜养血清热固冲，方用保阴煎加菟丝子、桑寄生、杜仲。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('健固汤', '经典方剂', '补益剂', '健脾渗湿。', '妇人脾虚湿盛，经前泄水。', '气虚甚者，加黄芪；泄水量多不止者，加芡实、乌贼骨、莲子须；腰酸甚者，加续断、桑寄生、杜仲、狗脊。', '傅青主女科');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('八物汤', '经典方剂', '补益剂', '益气补血。', '血虚不足。', '血虚生热者，可加牡丹皮、栀子；血虚不寐者，加酸枣仁、枸杞。', '女科切要');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('八珍汤（原名八珍散）', '经典方剂', '补益剂', '益气补血。', '气血两虚证。面色萎白或无华，头晕目眩，四肢倦怠， 气短懒言，心悸怔忡，饮食减少，舌淡苔薄白，脉细弱或虚大无力。', '若以血虚为主，眩晕心悸明显者，可加大熟地、白芍用量；以气虚为主，气短乏力明显者，可加大人参、白术用量；兼见不寐者，可加酸枣仁、五味子。', '瑞竹堂经验方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('六味地黄丸（原名地黄丸）', '经典方剂', '补益剂', '填精滋阴补肾。', '肾阴精不足证。腰膝酸软，头晕目眩，视物昏花，耳鸣耳聋，盗汗，遗精，消渴，骨蒸潮热，手足心热，舌燥咽痛，牙齿动摇，足跟作痛，以及小儿囟门不合，舌红少苔，脉沉细数。', '若虚火明显者，加知母、玄参、黄柏等以加强清热降火之功；兼脾虚气滞者，加白术、砂仁、陈皮等以健脾和胃；若眼睛干涩者，加枸杞、菊花以滋肾养肝明目；若肺阴亏虚者，加麦冬、五味子以滋养肺阴。', '小儿药证直诀');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('养精种玉汤', '经典方剂', '补益剂', '补肾养血。', '肾亏血虚，身体瘦弱，久不受孕。', '若胁肋隐痛，两目干涩者，加女贞子、旱莲草柔肝养阴；面色萎黄，头晕眼花者，加龟甲、紫河车填精养血；阴虚潮热者，加地骨皮、牡丹皮、知母滋阴清热。', '傅青主女科');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('养荣壮肾汤', '经典方剂', '补益剂', '补肾强腰壮筋骨。', '产后腰脊酸痛，腿脚乏力，或足跟，舌淡红胎薄，脉沉细。', '阴血亏虚较甚者，可加熟地以补血填精滋肾。', '叶氏女科证治');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('内补丸', '经典方剂', '补益剂', '温肾培元，固涩止带。', '带下量多，色白清冷，稀薄如水，淋漓不断，头晕耳鸣，腰痛如折，畏寒肢冷，小腹冷感，小便频数，夜间尤甚，大便稀薄，面色晦暗，舌淡润，苔薄白，脉沉细而迟。', '若腹泻便溏者，去肉苁蓉，酌加补骨脂、肉豆蔻。', '女科切要');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('加减驻景丸', '经典方剂', '补益剂', '补肝益肾，填精养血。', '视瞻昏渺（眼内干涩，视物昏朦，或观物变形。眼底可无明显异常，或见脉络膜视网膜病灶色素沉着，病变比较陈旧，间或夹杂新的渗出斑，抑或黄斑区轻度水肿，有渗出物及色素沉着。全身症见头晕耳鸣，夜眠多梦，腰膝酸软，脉细。）、青盲、近视（视近怯远，眼前黑花渐生。全身可有头晕耳呜，夜眠多梦，腰膝酸软，脉细）。', '视力日减、视野渐窄者，加党参、白芍、川芎、当归等以益气养血；若见面白肢冷，精神倦怠，偏肾阳虚者，可用肾气丸加减。', '银海精微');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('加味四君子汤', '经典方剂', '补益剂', '益气健脾。', '治痔血已久，脾胃气虚，面色萎黄，心悸耳鸣，脚弱气乏，口淡，食不知味。', '若胃脘满闷、恶心呕吐、嗳气者，加半夏、陈皮；食少纳呆、脘腹饱胀、食积不化者，加神曲、麦芽、山楂、鸡内金；若腹痛即泻、手足欠温者，加肉桂、炮姜；若有胃下垂、脱肛、腹部坠胀者，可改用补中益气汤；若伴各种出血，可用归脾汤。', '三因极一病证方论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('加味四物汤', '经典方剂', '补益剂', '养血熄风。', '主血虚脉空，自鱼尾上攻头痛者。', '视力减退者、可加党参、黄芪以益气养血。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('十全大补汤', '经典方剂', '补益剂', '温补气血。', '气血不足。症见饮食减少，久病体虚，脚膝无力，面色萎黄，精神倦怠，以及疮疡不敛，妇女崩漏。', '脓肿破溃，脓液稀薄淋漓不尽者，加用托里消毒散（人参、黄芪、白术、茯苓、甘草、当归、川芎、白芍、银花、白芷、连翘）。', '医学发明');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('十珍汤', '经典方剂', '补益剂', '滋阴降火，养血清肝。', '赤痛如邪症。阴虚火动，目赤痛，头痛，寒热交作，如风寒疟疾状。', '若白睛红赤者，加黄芩、栀子以清热；若眼干涩者，加天花粉、玉竹以生津。', '审视瑶函');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('十补丸', '经典方剂', '补益剂', '补益肾阳，滋养津血。', '肾阳虚损，津血不足。症见面色黧黑，足冷足肿，耳鸣耳聋，肢体羸瘦，足膝软弱，小便不利，腰脊疼痛。', '若腰痛如折，畏寒肢冷者，酌加淫羊藿、菟丝子以温阳益肾；若大便溏薄，面肢浮肿者，酌加黄芪、桂枝以温阳益气利水；面色晦暗兼有色斑，少腹冷痛者，酌加蒲黄、香附以温阳活血理气。', '济生方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('升阳益胃汤', '经典方剂', '补益剂', '益气升阳，清热除湿。', '脾胃虚弱、怠惰嗜卧；时值秋燥令行，湿热方退，体重节痛，口苦舌干，心不思食，食不知味，大便不调，小便频数。', '无腹痛者，去白芍；腹胀肠鸣者，加广木香、台乌。', '内外伤辨惑论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('升陷汤', '经典方剂', '补益剂', '益气升陷。', '胸中大气下陷，气短不足以息，或努力呼吸，有似乎喘；或气息将停，危在顷刻。其兼证，或寒热往来，或咽干作渴，或满闷怔仲，或神昏健忘，其脉象沉迟微弱，关前尤甚。其剧者，或六脉不全，或参伍不调', '气分虚极下陷者，酌加人参数钱，或再加山萸肉（去净核）数钱，以收敛气分之耗散，使升者不至复陷更佳；若大气下陷过甚，至少腹下坠，或更作疼者，宜将升麻改用钱半，或倍作2钱。', '医学衷中参西录');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('参苓白术散', '经典方剂', '补益剂', '益气健脾，渗湿止泻。', '脾虚湿盛证。饮食不化，胸脘痞闷，肠鸣泄泻，四肢乏力，形体消瘦，面色萎黄，舌淡苔白腻，脉虚缓。亦可用治肺脾气虚， 痰湿咳嗽。', '若兼里寒而腹痛者，加干姜、肉桂以温中祛寒止痛。', '太平惠民和剂局方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('参蛤散', '经典方剂', '补益剂', '纳气归肾。', '喘证、哮证肾不纳气证症见气不得续，动则喘甚， 呼多吸少，形神衰惫，舌淡，脉沉细。', '若脐下筑筑跳动，气从少腹上冲胸咽，为肾失潜纳，加紫石英、磁石、沉香；肾阴虚者，宜用七味都气丸合生脉散加减。如肺虚有寒，怕冷，舌质淡，加桂枝、细辛。兼阴伤，低热，舌红苔少，加麦冬、玉竹、知母；喘促重者加白果；浮肿者可加生姜、大腹皮。', '济生方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('右归丸', '经典方剂', '补益剂', '温补肾阳，填精益髓。', '肾阳不足，命门火衰证。年老或久病气衰神疲，畏寒肢冷，腰膝软弱，阳痿遗精，或阳衰无子，或饮食减少，大便不实，或小便自遗，舌淡苔白，脉沉而迟。', '若阳衰气虚，加人参以补之；阳虚精滑或带浊、便溏，加补骨脂以补肾固精止泻；肾泄不止，加五味子、肉豆蔻以涩肠止泻；饮食减少或不易消化，或呕恶吞酸，加干姜以温中散寒；腹痛不止，加吴茱萸（炒）以散寒止痛；腰膝酸痛者，加胡桃肉以补肾助阳，益髓强腰；阳痿者，加巴戟天、肉苁蓉以补肾壮阳。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('右归饮', '经典方剂', '补益剂', '温补肾阳。', '肾阳不足，阳衰阴胜，腰膝瘦痛，神疲乏力，畏寒肢冷，咳喘，泄泻，脉弱；以及产妇虚火不归元而发热者。', '阳虚精滑者，加补骨脂以补肾固精；肾泄不止，加五味子、肉豆蔻以涩肠止泻；腹痛不止者，加吴茱萸以散寒止痛；腰膝酸痛者，加胡桃肉以补肾助阳；阳痿者，加巴戟天、肉苁蓉补肾壮阳。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('四物五子丸', '经典方剂', '补益剂', '补益肝肾。', '肝肾不足，眼目昏暗。', '黄斑区渗出较多、色素紊乱者，加山楂、昆布、海藻以软坚散结；偏肾阳虚者，加山茱萸、补骨脂、仙灵脾以温补肾阳；肝肾阴虚明显者，加楮实子、桑椹、山萸肉以滋补肝肾；伴脾胃虚弱者，加白术、党参健脾益气。', '审视瑶函');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('四物汤', '经典方剂', '补益剂', '补血调血。', '营血虚滞证。头晕目眩，心悸失眠，面色无华，或妇人月经不调，量少或经闭不行，脐腹作痛，舌淡，脉细弦或细涩。', '若兼气虚者，加人参、黄芪，以补气生血；以血滞为主者，加桃仁、红花，白芍易为赤芍，以加强活血祛瘀之力；血虚有寒者，加肉桂、炮姜、吴萸，以温通血脉；血虚有热者，加黄芩、丹皮，熟地易为生地，以清热凉血；妊娠胎漏者，加阿胶、艾叶，以止血安胎。', '仙授理伤续断秘方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('固阴煎', '经典方剂', '补益剂', '养阴固精。', '阴虚滑泄，带浊淋遗，及经水因虚不固，肝肾并亏等证。', '若经血量多者，加仙鹤草、血余炭收涩止血；量多色淡者，加艾叶炭、杜仲温经止血；腰腹冷痛，小便频数者，加益智仁、补骨脂以温肾固涩；若腰骶酸痛者，酌加杜仲、巴戟天；带下量多者，加鹿角霜、沙苑子、金樱子。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('圣愈汤', '经典方剂', '补益剂', '益气养血。', '诸恶疮血出过多，心烦不安，不得睡眠，一切失血或血虚，烦渴燥热，睡卧不宁；疮证脓水出多，五心烦热，口渴；妇女月经超前，量多色淡，其质清稀，少腹有空坠感，心慌气促，倦怠肢软，纳谷不香，舌质淡，苔薄润，脉细软。气血虚弱，气不摄血证。月经先期而至，量多色淡，四肢乏力，体倦神衰。', '若月经夹血块者，酌加蒲黄、五灵脂以活血止痛；若伴有经行便溏，腹痛严重者，可去当归，加茯苓、炒白术以健脾止泻；失眠多梦，心脾虚者，酌加远志、合欢皮、夜交藤，以养心安神；若伴畏寒肢冷，腰腹冷痛，可加肉桂、小茴香、艾叶散寒止痛。', '医宗金鉴·妇科心法要诀');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('地芝丸', '经典方剂', '补益剂', '滋阴增液明目。', '可用于屈光不正引起的视疲劳，眼内干涩酸痛，属阴虚者；亦用于干燥性角膜炎、干眼综合征、表层点状角膜炎等病。', '眼睛干涩者，可加麦冬、枸杞以滋阴。', '审视瑶函');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('地黄饮', '经典方剂', '补益剂', '凉血润燥，祛风止痒。', '主血风疮、旋耳疮迁延日久，血虚化燥生风，身体或耳内生疮如粟米，瘙痒无度，疮面粗糙，上覆痂皮或鳞屑，心烦便秘，夜不得寐。', '痒甚者，可加蝉蜕、地肤子、白鲜皮等以祛风止痒。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('地黄饮子', '经典方剂', '补益剂', '滋肾阴，补肾阳，开窍化痰。', '喑痱。舌强不能言，足废不能用，口干不欲饮，足冷面赤，脉沉细弱。', '若属痱而无喑者，减去石菖蒲、远志等宣通开窍之品；喑痱以阴虚为主，痰火偏盛者，去附、桂，酌加川贝母、竹沥、胆南星、天竺黄等以清化痰热；兼有气虚者，酌加黄芪、人参以益气。', '黄帝素问宣明论方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('大补阴丸（原名大补丸）', '经典方剂', '补益剂', '滋阴降火。', '阴虚火旺证。骨蒸潮热，盗汗遗精，咳嗽咯血，心烦易怒，足膝疼热或痿软，舌红少苔，尺脉数而有力。', '若阴虚较重者，可加天门冬、麦门冬以润燥养阴；阴虚盗汗者，可加地骨皮以退热除蒸；咯血、吐血者，加仙鹤草、旱莲草、白茅根以凉血止血；遗精者，加金樱子、芡实、桑螵蛸、山茱萸以固精止遗。', '丹溪心法');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('安冲汤', '经典方剂', '补益剂', '益气健脾，安冲摄血。', '脾气虚弱，冲脉不固，妇女月经过多，经行时久，过期不止或不时漏下等。', '久崩不止，症见头昏、乏力、心悸失眠者，酌加何首乌、桑寄生、五味子养心安神；脘腹胀闷者，加黑荆芥、煨木香、枳壳宽中行气；崩中量多者，加侧柏叶、仙鹤草、血余炭敛阴涩血止血。', '医学衷中参西录');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('定经汤', '经典方剂', '补益剂', '舒肝补肾，养血调经。', '主肝肾气郁，经来断续，或前或后，行而不畅，有块，色正常，少腹胀痛，或乳房胀痛连及两胁。', '经有血块者，加桃仁、红花、川芎；肝郁者，加郁金，香附。', '傅青主女科');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('寿胎丸', '经典方剂', '补益剂', '固肾安胎。', '孕妇胎元不固，症见胎动不安，腰酸腹坠，下血见红，或屡有滑胎，以及胎萎不长，胎音微弱，舌淡苔白，脉沉弱。', '若小腹下坠明显，加黄芪、升麻益气升提安胎；若大便秘结，加肉苁蓉、熟地黄、桑椹滋肾增液润肠。', '医学衷中参西录');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('小营煎', '经典方剂', '补益剂', '养血益阴。', '血少阴亏之症。', '若大便干结者，加火麻仁、冬瓜仁润肠通便；下腹有包块者，加三棱、莪术以消癥散结。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('左归丸', '经典方剂', '补益剂', '滋阴补肾，填精益髓。', '真阴不足证。头晕目眩，腰酸腿软，遗精滑泄，自汗盗汗，口燥舌干，舌红少苔，脉细。', '若真阴不足，虚火上炎，去枸杞子、鹿角胶，加女贞子、麦门冬以养阴清热；火烁肺金，干咳少痰，加百合以润肺止咳；夜热骨蒸，加地骨皮以清热除蒸；小便不利，加茯苓以利水渗湿；大便燥结，去菟丝子，加肉苁蓉以润肠通便；兼气虚者可加人参以补气。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('左归饮', '经典方剂', '补益剂', '滋阴补肾。', '真阴不足，腰癀且痛，遗精盗汗，咽燥口渴。', '若流泪较甚者，加五味子、防风以收敛祛风止泪；若感泪液清冷者，加巴戟天、肉苁蓉、桑螵蛸，以加强温补肾阳之力而助固摄止泪之功；夜热骨蒸者，加地骨皮以清热除蒸；大便燥结，去菟丝子，加肉苁蓉以润肠通便。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('归肾丸', '经典方剂', '补益剂', '补阴益阳，养血填精。', '肾水真阴不足，精衰血少，腰痠脚软，形容憔悴，遗泄阳衰。', '如小腹凉、夜尿多、手足不温，加益智仁、巴戟天、淫羊藿、补骨脂温补肾阳；若五心烦热，颧红，加女贞子、白芍、龟甲、地骨皮等养阴清热；若经行淋沥不净，加茜草、乌贼骨化瘀止血。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('归芍六君子汤', '经典方剂', '补益剂', '益气补血，燥湿化痰。', '主脾胃不健，气血两亏所致之咳嗽痰多，纳少，神疲，膨胀腹满，呕吐，下血，妊娠痢疾及妇人经水不调。', '若脾虚胃弱明显者，可配服香砂六君子汤以健脾和胃。', '笔花医镜');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('当归地黄饮', '经典方剂', '补益剂', '补益肝肾。', '肝肾阴亏，腰膝疼痛等证。', '若肾气不足，日久伤阳，症见腰膝酸冷者，可酌加菟丝子、巴戟天、淫羊藿等以温肾阳，强腰膝；带下量多清稀者，酌加鹿角霜、金樱子温肾固涩止带。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('当归散', '经典方剂', '补益剂', '养血健脾，清热安胎。', '妊娠胎动不安。', '肝血亏虚甚者，可加生地黄、枸杞以滋肝阴；脾虚甚者，加党参、茯苓、黄芪以健脾益气；湿热较甚者，加黄连、泽泻、栀子以清热利湿；血虚生内热者，加栀子、丹皮以清热凉血。', '金匮要略');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('当归活血饮', '经典方剂', '补益剂', '养血补血，熄风止痉。', '肝脾血虚而气不和顺，睥轮振跳，即目睥不待人之开合，而自率拽振跳。', '常去方中羌活、薄荷；若胞睑振跳等症持续不休者，酌加僵蚕、天麻、钩藤等以养血平肝息风。', '审视瑶函');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('当归补血汤', '经典方剂', '补益剂', '补气生血。', '血虚发热证。肌热面赤，烦渴欲饮，脉洪大而虚，重按无力。亦治妇人经期、产后血虚发热头痛，或疮疡溃后，久不愈合者。', '若妇女经期，或产后感冒发热头痛者，加葱白、淡豆豉、生姜、大枣以疏风解表；若疮疡久溃不愈，气血两虚而又余毒未尽者，可加银花、甘草以清热解毒；若血虚气弱出血不止者，可加煅龙骨、阿胶、山茱萸以固涩止血。', '内外伤辨惑论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('慎柔养真汤', '经典方剂', '补益剂', '益气健脾，滋养脾阴。', '损病六脉俱数，声哑，口中生疮，昼夜发热无间。', '脾阴虚生热者，加防风、生石膏、栀子、藿香。', '慎柔五书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('无比山药丸', '经典方剂', '补益剂', '温阳益精，补肾固摄。', '治肾气虚惫，头晕目眩，耳鸣腰酸，冷痹骨痛，四肢不温，或烦热有时，遗精盗汗，尿频遗屎，或带下清冷，舌质淡，脉虚冷。', '若中气下陷者，可用补中益气汤加减；若尿血较重者，加牡蛎、金樱子、补骨脂；腰脊酸痛、畏寒神怯者，加鹿角片、狗脊。', '太平惠民和剂局方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('明目地黄丸', '经典方剂', '补益剂', '补益肝肾，滋阴明目。', '视瞻昏渺证属肝肾亏虚者，以及眼见黑花，圆翳内障，视大变小。', '方中可加川芎、丹参、牛膝，以增活血化瘀通络之功；如多梦盗汗者，加知母、牡丹皮、黄柏等以滋阴清热；眼干涩不适者，可加天花粉、玄参以养阴清热活血。', '审视瑶函');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('明目地黄汤', '经典方剂', '补益剂', '滋养肝肾，益精明目。', '肝肾阴虚，目涩畏光，视物模糊，迎风泪流。', '若玻璃体混浊较重，酌加牛膝、丹参以助补肝肾、养血活血；虚火伤络者加知母、黄柏、墨旱莲以养阴清热凉血；方中加麝香、石菖蒲以增开窍明目之功，加丹参、川芎、牛膝以增活血化瘀之力。', '眼科证治经验');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('月华丸', '经典方剂', '补益剂', '滋阴润肺，化痰止咳。', '阴虚咳嗽。', '若咳而痰少质黏者，可酌加甜杏仁、贝母、海蛤壳、竹茹；痰中带血较多者，宜加白及、仙鹤草、白茅根、藕节等；若低热不退，可配银柴胡、地骨皮、功劳叶、胡黄连等；若久咳不已，声音嘶哑者，加诃子皮、木蝴蝶、凤凰衣；咽喉不利者，可加桔梗、甘草宣肺利咽。', '医学心悟');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('杜仲丸', '经典方剂', '补益剂', '补肾滋阴，益气养血。', '肾虚腰痛，动止软弱，脉大虚，疼不已。', '肾精亏虚者，酌加山药、何首乌、熟地以补益肾精。', '医学入门');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('桃红四物汤', '经典方剂', '补益剂', '养血活血。', '血虚兼血瘀证。妇女经期超前，血多有块，色紫稠粘，腹痛等。', '头目胀痛甚者，加蔓荆子、菊花、石决明以祛风镇痛；若小腹胀痛，加路路通、红藤、忍冬藤活血通络；小腹冷痛，加肉桂、小茴香以温经止痛；神疲乏力，加党参、白术、黄芪健脾益气；瘀热互结者，酌加生地黄、黄芩、益母草以清热化瘀止血；心烦眠差者，加栀子、酸枣仁；疼痛剧烈者，加制乳香、制没药、蜈蚣；月经色暗，经前加重者，加益母草、泽兰；胸胁胀痛者，加柴胡、郁金；痛经者，加香附、乌药、益母草；伴囊肿成脓者，加贝母、皂角刺、夏枯草；伴结节、囊肿难消者，加三棱、莪术、海藻、昆布。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('止泪补肝散', '经典方剂', '补益剂', '补肝止泪。', '肝虚流泪，迎风泪不止。', '若流泪迎风更甚者，可加白薇、菊花、石榴皮等以祛风止泪。', '银海精微');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('毓麟珠', '经典方剂', '补益剂', '益气补血，温肾养肝，调补冲任。', '妇人气血俱虚，经脉不调，或断续，或带浊，或腹痛，或腰酸，或饮食不甘，瘦弱不孕。', '若经来量多者，加阿胶、炒艾叶固冲止血；若经来量少不畅者，加丹参、鸡血藤活血调经；若心烦少寐者，加柏子仁、夜交藤养心安神；腰酸腿软甚者，加续断、桑寄生补肾强腰。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('河车大造丸', '经典方剂', '补益剂', '滋阴填精，补养肺肾。', '虚损劳伤，精血亏虚，肺肾不足之虚劳咳嗽。', '精血不足甚者，加何首乌、阿胶。', '诸证辨疑');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('济生肾气丸', '经典方剂', '补益剂', '温肾化气，利水消肿。', '用于肾虚水肿，腰膝酸重，小便不利，痰饮喘咳。', '少腹胀痛者，加乌药、木香、小茴香；如伴有脾虚者，可酌加黄芪、炒白术等；若腰痛甚者，酌加巴戟天、杜仲、续断、桑寄生以补肾强腰；小腹下坠者，酌加黄芪、党参、升麻以益气温阳。', '济生方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('温肺止流丹', '经典方剂', '补益剂', '补益肺气，疏散寒邪。', '治鼻渊属肺气虚者。', '鼻痒甚，可酌加僵蚕、蝉蜕；若畏风怕冷、清涕如水者，可酌加桂枝、干姜、大枣等。若头额冷痛，可酌加羌活、白芷、川芎等；若畏寒肢冷、遇寒加重者，可酌加防风、桂枝等；若鼻涕多者，可酌加半夏、陈皮、薏苡仁等；若自汗恶风者，可酌加黄芪、白术、防风等。鼻塞甚者，加辛夷花、白芷芳香通窍。', '辨证录');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('温胞饮', '经典方剂', '补益剂', '温肾助阳，化湿固精。', '婚久不孕，月经后期，量少色淡，甚则闭经，平时白带量多，腰痛如折，腹冷肢寒，性欲淡漠，小便频数或不禁，面色晦黯，舌淡，苔白滑，脉沉细而迟或沉迟无力。', '若小便清长，夜尿多者，加益智仁、桑螵蛸补肾缩小便；性欲淡漠者，加紫石英、肉苁蓉温肾填精；血肉有情之品如紫河车、龟甲、鹿茸等，具补肾阴阳，通补奇经之效，可适时加味；腹痛较甚者，加延胡索、苏木活血化瘀止痛；夹湿者，加薏苡仁、苍术健脾燥湿。', '傅青主女科');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('滋血汤', '经典方剂', '补益剂', '养血调经。', '月经过少，或点滴即净，色淡无块，或伴头晕眼花，心悸怔忡，面色萎黄，小腹空坠。舌质淡红，脉细。', '若面色苍白，重用黄芪、加鸡血藤以益气生血；经血亏少，宜加枸杞子、山茱萸、丹参、香附，以滋养肝肾，填精益血。', '证治准绳');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('滋阴退翳汤', '经典方剂', '补益剂', '滋阴退翳。', '翳膜初结，干涩不适，视物昏暗。', '可加北沙参、天冬以助养阴生津；黑睛有翳、羞明者，宜加石决明、海螵蛸、蝉蜕、谷精草以增退翳明目之功；眼仍有轻微红赤者，可加黄芩、夏枯草以清余邪退翳；翳中赤脉牵绊者，可加秦皮、红花以活血退翳；伴有舌淡脉弱者，可加太子参以益气退翳。', '眼科临床笔记');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('滋阴降火汤', '经典方剂', '补益剂', '滋阴降火。', '阴虚火旺之白睛溢血、混睛障、血灌瞳神，内障昏花，萤星满目。', '可加木贼、蝉蜕以退翳明目；腰膝酸软者，可加牛膝、枸杞子、菟丝子以增滋补肝肾之功；出血初期宜加荆芥炭、白茅根以凉血止血；反复发作日久者，可加浙贝母、昆布以软坚散结；可于方中加三七粉、郁金以助活血化瘀；若出血日久不吸收者，可加丹参、泽兰、浙贝母等活血消滞；大便干结者，可加火麻仁润肠通便。', '审视瑶函');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('滋阴除湿汤', '经典方剂', '补益剂', '滋阴养血，除湿润燥。', '鹳口疽初起，朝寒暮热，日轻夜重，状如疟疾。', '阴虚火旺者，加牡丹皮、女贞子、旱莲草。', '外科正宗');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('炙甘草汤（又名复脉汤）', '经典方剂', '补益剂', '滋阴养血，益气温阳，复脉定悸。', '1.阴血不足，阳气虚弱证。脉结代，心动悸，虚羸少气，舌光少苔，或质干而瘦小者。 2.虚劳肺痿。咳嗽，涎唾多，形瘦短气，虚烦不眠，自汗盗汗，咽干舌燥，大便干结，脉虚数。', '方中可加酸枣仁、柏子仁以增强养心安神定悸之力，或加龙齿、磁石重镇安神；偏于心气不足者，重用炙甘草、人参；偏于阴血虚者重用生地、麦门冬；心阳偏虚者，易桂枝为肉桂，加附子以增强温心阳之力；阴虚而内热较盛者，易人参为南沙参，并减去桂、姜、枣、酒，酌加知母、黄柏，则滋阴液降虚火之力更强。', '伤寒论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('独参汤', '经典方剂', '补益剂', '大补元气。', '诸虚气弱危急者。', '若自汗肤冷、呼吸微弱者，加附子、干姜；若口干少津者，加麦冬、玉竹、沙参；心悸少寐者，加龙眼肉、酸枣仁。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('玉泉丸', '经典方剂', '补益剂', '益气养阴，生津止渴。', '消渴口干。', '脾阴亏虚者，加山药、莲子肉；肾阴亏虚者，加熟地黄、何首乌；口渴者，加玉竹、石斛。', '仁斋直指方论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('玉烛散', '经典方剂', '补益剂', '养血清热，泻积通便。', '血虚发热，大便秘结；或妇女经候不通，腹胀作痛；或产后恶露不尽，脐腹疼痛；或胃热消渴，善食渐瘦；或背疮初发。', '若脘腹胀甚者，加鸡内金、佛手、枳壳；心烦口臭、口疮者，加黄芩、栀子、竹叶。', '儒门事亲');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('生姜甘草汤', '经典方剂', '补益剂', '补脾益肺，散寒化饮。', '治肺痿咳唾涎沫不止，咽燥而渴。', '如脾气虚弱，纳少神疲，加白术、茯苓；肺虚失约，唾沫多而尿频者，加益智仁、白果等；肾虚而不能纳气者，加钟乳石、五味子，另吞服蛤蚧粉（每次2g，一日2次）。', '备急千金要方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('生脉地黄汤', '经典方剂', '补益剂', '滋补肺肾，益气生津。', '虚劳，火盛刑金者。久哮肺肾两虚者。', '如阴虚明显者，加北沙参、天冬、石斛、炙鳖甲；气虚明显者，加生黄芪、太子参、白术、仙鹤草；口渴明显者，加芦根、天花粉、知母；咳痰不利、痰少而黏者，加贝母、百部、杏仁；五心烦热、潮热盗汗者，加知母、黄柏、地骨皮、煅龙骨、煅牡蛎。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('生蒲黄汤', '经典方剂', '补益剂', '活血化瘀，凉血止血。', '云雾移睛。自觉眼前黑花飞舞，视力缓降或急降。检视玻璃体，可见点状或絮状、团块状浑浊，或见眼底有出血性病变。全身常见头晕耳呜，心烦少寐，口燥咽于，舌红少苔，脉弦细数。', '本方可加三七粉、郁金以助活血化瘀；若出血日久不吸收者，可加丹参、泽兰、浙贝母等活血消滞；大便干结者，可加火麻仁润肠通便；止血用生蒲黄汤加减；若出血较多可加血余炭、仙鹤草以加强止血之功。', '中医眼科六经法要');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('益气导溺汤', '经典方剂', '补益剂', '益气升提。', '妊娠气虚下陷，小便不通，脐腹胀痛，面色苍白带青，心悸气短，神倦食少，舌淡苔白，脉沉滑无力。', '若气虚甚者，加黄芪、山药等。', '中医妇科治疗学');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('益气聪明汤', '经典方剂', '补益剂', '益气升阳，聪耳明目。', '治脾胃气虚，致患内障，目糊，视物昏花，神水变淡绿色，次成歧视（复视），久则失明，神水变成纯白色；亦治耳聋，耳鸣。现多用于老年性白内障、色弱、色盲、听力减退属于气虚清阳不升者。', '若兼湿浊而苔腻者，可加茯苓、白术、砂仁以健脾祛湿；若手足不温者，可加干姜、桂枝、附子以温阳；若不寐者，可加酸枣仁以安神；若头痛绵绵不休、心悸者，加当归、熟地黄、何首乌。', '东垣试效方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('益肾调经汤', '经典方剂', '补益剂', '温肾调经。', '妇女肾虚，经来色淡而多，经后腹痛腰酸，肢软无力，脉沉弦无力。', '腰痛较甚者，加桑寄生、狗脊；下焦虚寒者，可酌加肉桂。', '中医妇科治疗学');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('知柏地黄丸', '经典方剂', '补益剂', '滋阴降火。', '肝肾阴虚，虚火上炎证。头目昏眩，耳鸣耳聋，虚火牙痛，五心烦热，腰膝酸痛，血淋尿痛，遗精梦泄，骨蒸潮热，盗汗颧红，咽干口燥，舌质红，脉细数。', '若心烦失眠者，可加麦冬、五味子、酸枣仁以养心安神；若夜梦多者，加龙骨、牡蛎以镇心安神；若出血量多者，加丹参、赤芍以养血活血化瘀；腰膝酸软者，加女贞子、墨旱莲以补肝益肾；若阴亏虚火上炎，加地骨皮、石斛；阴虚阳亢者，酌加龟甲、鳖甲滋阴潜阳；瘀血内停者，酌加丹参、茺蔚子、益母草活血明目；口干喜饮者宜加石斛、天花粉、生石膏以生津止渴；尿中带血者，加白茅根、小蓟等以清热凉血止血。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('石斛夜光丸', '经典方剂', '补益剂', '滋阴补肾，清肝明目。', '用于肝肾两亏，阴虚火旺，内障目暗，视物昏花。', '视物模糊者，加木贼、谷精草以明目。', '原机启微');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('耳聋左慈丸', '经典方剂', '补益剂', '补肝肾，通耳窍。', '主肾虚精脱，耳鸣耳聋。', '若偏于肾阳虚，治宜温补肾阳，可选用右归丸或肾气丸加减。', '重订广温热论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('肠宁汤', '经典方剂', '补益剂', '益气补血。', '妇人产后亡血过多，血虚少腹疼痛，按之即止。', '若血虚津亏便秘较重者，去肉桂，加肉苁蓉、火麻仁润肠滋液通便；若腹痛兼有下坠感，为血虚兼气不足，加黄芪、白术益气升提；若腹痛喜热熨者，加吴茱萸、艾叶、小茴香、炮姜温阳行气、暖宫止痛。', '傅青主女科');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('肾气丸（又名《金匮》肾气丸、崔氏八味丸）', '经典方剂', '补益剂', '补肾助阳，化生肾气。', '肾阳气不足证。腰痛脚软，身半以下常有冷感，少腹拘急，小便不利，或小便反多，入夜尤甚，阳痿早泄，舌淡而胖，脉虚弱，尺部沉细；以及痰饮，水肿，消渴，脚气，转胞等。', '方中熟地黄，现多用熟地；桂枝改用肉桂，如此效果更好；若夜尿多者，宜肾气丸加五味子；小便数多，色白体羸，为真阳亏虚，宜加补骨脂、鹿茸等，加强温阳之力；若用于阳痿，证属命门火衰者，酌加淫羊藿、补骨脂、巴戟天等以助壮阳起痿之力。', '金匮要略');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('胎元饮', '经典方剂', '补益剂', '补气养血，固肾安胎。', '妇人冲任失守，胎元不安不固。气血两虚而胎不安者，六脉微弱，神昏气倦，一切不足之证。', '若阴道流血量多者，加乌贼骨以固冲止血；若气虚明显，小腹下坠，加黄芪、升麻益气升提，固摄胎元。若兼气滞，酌加苏梗、砂仁理气行滞；大便秘结者，加玄参、肉苁蓉润肠通便。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('荆穗四物汤', '经典方剂', '补益剂', '解表散寒，和血调经。', '血虚头晕。', '风寒较轻者，加葱白、淡豆豉。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('虎潜丸', '经典方剂', '补益剂', '滋阴降火，强筋壮骨。', '肝肾阴虚，精血不足，筋骨软弱，腿足消瘦，行走无力，舌红少苔，脉细弱，现用于脊髓灰质炎后遗症，慢性关节炎，中风后遗症而属肝肾不足者。', '若兼有神疲、怯寒怕冷，不可过用寒凉以伐生气，去黄柏、知母，加仙灵脾、鹿角霜、紫河车、附子、肉桂；若见面色无华、头昏心悸，加黄芪、党参、何首乌、龙眼肉、当归；腰脊酸软，加续断、补骨脂、狗脊；热甚者，可去锁阳、干姜，或服用六味地黄丸加牛骨髓、鹿角胶、枸杞子；阳虚畏寒，脉沉弱，加右归丸加减。', '丹溪心法');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('补中益气汤', '经典方剂', '补益剂', '补中益气，升阳举陷。', '1.脾胃气虚证。饮食减少，体倦肢软，少气懒言，面色萎黄，大便稀薄，脉虚软。 2.气虚下陷证。脱肛，子宫脱垂，久泻，久痢，崩漏等，伴气短乏力，舌淡，脉虚。 3.气虚发热证。身热自汗，渴喜热饮，气短乏力，舌淡，脉虚大无力。', '若兼腹中痛者，加白芍以柔肝止痛；头痛者，加蔓荆子、川芎；头顶痛者，加藁本、细辛以疏风止痛；咳嗽者，加五味子、麦冬以敛肺止咳；兼气滞者，加木香、枳壳以理气解郁。本方亦可用于虚人感冒，加苏叶少许以增辛散之力。', '内外伤辨惑论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('补天大造丸', '经典方剂', '补益剂', '补五脏虚损。', '虚劳。气短乏力，食少神疲，心悸失眠，腰膝酸软，头晕目眩等。', '若血虚者，加当归、熟地倍之；气虚者，人参、黄耆加量；肾虚者，加覆盆子（炒）、小茴香、巴戟（去心）、山茱萸（去核）；腰痛，加苍术、萆薢、琐阳、续断；骨蒸潮热者，加地骨皮、知母以除骨蒸；妇人去黄柏，加川芎、香附。', '医学心悟');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('补气运脾汤', '经典方剂', '补益剂', '益气和中。', '脾虚不运之噎膈。症见水饮不下，泛吐多量粘液白沫，或面浮足肿，面色苍白，形寒气短，精神疲惫，腹胀，舌质淡，苔白，脉细弱。', '若中阳不足，痰凝瘀阻，可用理中汤加姜汁、竹沥；胃虚气逆，呕吐不止者，可加旋覆花、代赭石；阳伤及阴，口干咽燥者，可加石斛、麦冬、沙参；泛吐白沫，加吴茱萸、丁香、豆蔻；肾阳虚明显者，可用右归丸或加附子、肉桂、鹿角胶、肉苁蓉。', '统旨方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('补肝汤', '经典方剂', '补益剂', '补养肝血，养筋明目。', '肝血不足，筋缓手足不能收持，目暗视物不清，舌质淡，脉弦细。', '若风阳内盛，见头痛、眩晕、耳鸣，或筋惕肉较甚者，加石决明、菊花、钩藤、刺蒺藜；若肝火亢盛者，加夏枯草、牡丹皮、栀子；两目干涩畏光，或视物不明者，加枸杞子、女贞子、草决明；若肝络失养，口燥咽干者，可选用一贯煎加减。', '医宗金鉴');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('补肺汤', '经典方剂', '补益剂', '补肺益气，止咳平喘。', '肺虚咳喘，短气自汗，声音低弱，舌淡，脉象虚弱。', '若咳逆，咳痰稀薄者，加款冬花、苏子、钟乳石等；偏阴虚者，加沙参、玉竹、百合、诃子；咳痰稠黏，加川贝母、百部；兼肾虚，动则喘甚，加山萸肉、胡桃肉、蛤蚧；肺脾两虚，中气下陷者，配合补中益气汤。若气短息促，加冬虫夏草，重用人参、黄芪；肺卫不固，易于感冒者，加防风、白术；自汗较多者，加牡蛎、麻黄根；若气阴两虚而兼见潮热、盗汗者，加鳖甲、地骨皮、秦艽。', '永类钤方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('补肾固冲丸', '经典方剂', '补益剂', '补肾固冲，调摄冲任。', '滑胎。屡孕屡堕，甚或如期而堕，头晕耳鸣，腰酸膝软，夜尿频多，目眶暗黑，或面色晦暗，舌淡，苔白，脉沉弱。', '腰膝酸软者，加补骨脂、桑寄生以强腰膝。', '中医学新编');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('补肾地黄汤', '经典方剂', '补益剂', '滋肾养血，壮水制火。', '阴虚血枯闭经证。症见月经停闭，形体羸瘦，骨蒸潮热，或咳嗽唾血，两颧潮红，舌绛少苔，甚或无苔，脉细数。', '咳血者，加阿胶、白茅根。', '陈素庵妇科补解');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('赞育丹', '经典方剂', '补益剂', '补肾壮阳。', '治男子阳痿精衰，虚寒不育。', '如火衰不甚，精血薄弱，可予左归丸或金匮肾气丸加减；如滑精频繁，精薄精冷，可加覆盆子、金樱子、益智仁补肾固精。', '景岳全书');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('还少丹', '经典方剂', '补益剂', '补益脾肾。', '脾肾虚损所致的腰膝酸痛，耳鸣目眩，形体消瘦，食欲减退，牙根酸痛；鹤膝风。', '若呃逆不食，口涎外溢，加炒白术、生黄芪、清半夏、炒麦芽；若夜尿频多，加菟丝子、蛇床子；若二便失禁，加益智仁、桑螵蛸。', '外科大成');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('通乳丹', '经典方剂', '补益剂', '补气养血，佐以通乳。', '产后乳少，甚或全无，乳汁清稀，乳房柔软，无胀满感，神倦食少，面色无华，舌淡，苔少，脉细弱。', '若食少便溏者，加炒白术、茯苓、炒扁豆健脾渗湿；头晕心悸者，加阿胶、白芍、何首乌养血安神。', '傅青主女科');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('青蛾丸', '经典方剂', '补益剂', '补肾壮腰。', '治肾气虚弱，风冷乘之，或血气相搏而腰痛如折，起坐艰难，俯仰不利，转侧不能；或足膝酸软，头晕耳鸣，遗精早泄，及妇女虚寒型白带。', '阳虚怕冷者，加附片、白术、干姜；阳虚性欲减退者，加淫羊藿、巴戟天。', '太平惠民和剂局方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('顺气归脾丸', '经典方剂', '补益剂', '健脾益气，理气消肿。', '思虑伤脾，脾气郁结，致生肉瘤，软如绵，肿似馒，脾气虚弱，日久渐大，或微疼或不疼。', '脾气郁结甚者，可酌加防风、升麻疏散脾胃郁结之气。', '外科正宗');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('顺经汤', '经典方剂', '补益剂', '补肾清肝。', '妇人肾阴不足，肝气上逆，经前一二日，忽然腹痛而吐血。', '若咯血甚者，可加白茅根，浙贝母、桔梗以滋肺镇咳以止血；吐血可口服大黄粉，或三七粉。', '傅青主女科');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('香砂六君子汤', '经典方剂', '补益剂', '益气健脾，行气化痰。', '气虚肿满，痰饮结聚，脾胃不和，变生诸证者。', '若脾胃虚寒者，酌加丁香、豆蔻以增强温中降逆之力；若吐甚伤阴，症见口干便秘者，宜去木香、砂仁、茯苓等温燥或淡渗之品，酌加玉竹、麦冬、石斛、胡麻仁等养阴和胃；若唾液明显增多，时时流涎者，可加益智仁、豆蔻温脾化饮，摄涎止唾。', '名医方论');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('鹿茸补涩丸', '经典方剂', '补益剂', '温肾助阳，补益精髓。', '主治浊病，下元虚冷，茎中不痛，脉来无力。', '食少纳差者；加焦山楂，神曲；便溏者；加诃子、草豆蔻；早泄者；加芡实、金樱子；性欲减退者；加淫羊藿、巴戟天。', '杂病源流犀烛');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('黄芪六一汤', '经典方剂', '补益剂', '益气生津。', '气虚血弱，肢体劳倦，胸中烦悸，时常焦渴，唇口干燥，面色萎黄，不思饮食、或先渴而发疮疖，或病痈疽而后渴者，或卫虚自汗等。', '若气阴亏虚甚者，可加人参、麦冬。', '经验方');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('龟鹿二仙胶', '经典方剂', '补益剂', '滋阴填精，益气壮阳。', '真元虚损，精血不足证。全身瘦削，阳痿遗精，两目昏花，腰膝酸软，久不孕育。', '若兼有眩晕者，加杭菊花、明天麻以熄风止晕；遗精频作者，加金樱子、山茱萸以补肾固精。', '医便');
INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source) VALUES
('龟鹿二仙膏', '经典方剂', '补益剂', '滋阴填精，益气壮阳。', '男、妇真元虚损，久不孕育；精极，梦泄遗精，瘦削少气，目视不明。', '若肢体颤抖、眩晕较著，加天麻、全蝎、石决明；若阴虚火旺，兼见五心烦热、躁动失眠、便秘溲赤，加黄柏、知母、丹皮、玄参；若肢体麻木、拘急强直，加木瓜、僵蚕、地龙，重用白芍、甘草。', '医便');

-- 插入方剂-药材关联数据
-- 假设: herb.name 唯一, formula.name 唯一
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '九仙散' AND h.name = '阿胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '九仙散' AND h.name = '款冬花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '九仙散' AND h.name = '罂粟壳';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '九仙散' AND h.name = '桑白皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '九仙散' AND h.name = '乌梅';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '九仙散' AND h.name = '桔梗';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '九仙散' AND h.name = '贝母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '九仙散' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '九仙散' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '桃花汤' AND h.name = '赤石脂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '桃花汤' AND h.name = '粳米';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '桃花汤' AND h.name = '干姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '桑螵蛸散' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '桑螵蛸散' AND h.name = '茯神';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '桑螵蛸散' AND h.name = '菖蒲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '桑螵蛸散' AND h.name = '龙骨';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '桑螵蛸散' AND h.name = '桑螵蛸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '桑螵蛸散' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '桑螵蛸散' AND h.name = '龟甲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '桑螵蛸散' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '真人养脏汤（原名纯阳真人养脏汤）' AND h.name = '肉豆蔻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '真人养脏汤（原名纯阳真人养脏汤）' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '真人养脏汤（原名纯阳真人养脏汤）' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '真人养脏汤（原名纯阳真人养脏汤）' AND h.name = '诃子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '真人养脏汤（原名纯阳真人养脏汤）' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '真人养脏汤（原名纯阳真人养脏汤）' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '真人养脏汤（原名纯阳真人养脏汤）' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '真人养脏汤（原名纯阳真人养脏汤）' AND h.name = '罂粟壳';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '真人养脏汤（原名纯阳真人养脏汤）' AND h.name = '木香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '真人养脏汤（原名纯阳真人养脏汤）' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '缩泉丸（原名固真丹）' AND h.name = '天台乌药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '缩泉丸（原名固真丹）' AND h.name = '益智仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '赤石脂禹余粮汤' AND h.name = '禹余粮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '赤石脂禹余粮汤' AND h.name = '赤石脂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '金锁固精丸' AND h.name = '沙苑子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '金锁固精丸' AND h.name = '龙骨';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '金锁固精丸' AND h.name = '牡蛎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '金锁固精丸' AND h.name = '芡实';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '金锁固精丸' AND h.name = '莲子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '龙骨散' AND h.name = '煅龙骨';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '龙骨散' AND h.name = '枯矾';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '交济汤' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '交济汤' AND h.name = '龙骨';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '交济汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '交济汤' AND h.name = '黄连';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '交济汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '交济汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '交济汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '交济汤' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '交济汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '交济汤' AND h.name = '柏子仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '柏子仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '半夏曲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '茯神';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '酸枣仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '养心汤' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '柏子仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '桔梗';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '玄参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '酸枣仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '天门冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '丹参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '天王补心丹' AND h.name = '麦门冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '石菖蒲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '益智仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '连翘';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '决明子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '龟甲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '钩藤';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '柴胡';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '郁金';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '安神定志灵' AND h.name = '天竺黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '定志丸' AND h.name = '茯神';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '定志丸' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '定志丸' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '定志丸' AND h.name = '石菖蒲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '桂枝甘草龙骨牡蛎汤' AND h.name = '牡蛎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '桂枝甘草龙骨牡蛎汤' AND h.name = '桂枝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '桂枝甘草龙骨牡蛎汤' AND h.name = '龙骨';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '桂枝甘草龙骨牡蛎汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '珍珠母丸（原名真珠丸）' AND h.name = '酸枣仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '珍珠母丸（原名真珠丸）' AND h.name = '犀角';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '珍珠母丸（原名真珠丸）' AND h.name = '龙齿';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '珍珠母丸（原名真珠丸）' AND h.name = '沉香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '珍珠母丸（原名真珠丸）' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '珍珠母丸（原名真珠丸）' AND h.name = '茯神';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1g'
FROM formula f, herb h
WHERE f.name = '珍珠母丸（原名真珠丸）' AND h.name = '珍珠母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '45g'
FROM formula f, herb h
WHERE f.name = '珍珠母丸（原名真珠丸）' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '45g'
FROM formula f, herb h
WHERE f.name = '珍珠母丸（原名真珠丸）' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '珍珠母丸（原名真珠丸）' AND h.name = '柏子仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '黄连';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '21g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '21g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '牛黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '21g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '石菖蒲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '龙齿';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '柏子仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '21g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '琥珀';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '21g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '酸枣仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '21g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.5g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '朱砂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '21g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '茯神';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '琥珀养心丹' AND h.name = '金箔';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '甘麦大枣汤' AND h.name = '小麦';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '甘麦大枣汤' AND h.name = '大枣';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '甘麦大枣汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '菖蒲丸' AND h.name = '麦门冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '菖蒲丸' AND h.name = '石菖蒲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '菖蒲丸' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '菖蒲丸' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.5g'
FROM formula f, herb h
WHERE f.name = '菖蒲丸' AND h.name = '朱砂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '菖蒲丸' AND h.name = '乳香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '菖蒲丸' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '菖蒲丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '黄连阿胶汤' AND h.name = '鸡子黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '黄连阿胶汤' AND h.name = '黄连';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '黄连阿胶汤' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '黄连阿胶汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '黄连阿胶汤' AND h.name = '阿胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '栀子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '朱砂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '犀角';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '郁金';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '黄连';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '珍珠母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '牛黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '雄黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '7.5g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '冰片';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '7.5g'
FROM formula f, herb h
WHERE f.name = '安宫牛黄丸' AND h.name = '麝香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '抱龙丸' AND h.name = '辰砂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '抱龙丸' AND h.name = '雄黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '抱龙丸' AND h.name = '天竺黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '120g'
FROM formula f, herb h
WHERE f.name = '抱龙丸' AND h.name = '天南星';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '抱龙丸' AND h.name = '麝香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.5g'
FROM formula f, herb h
WHERE f.name = '牛黄清心丸' AND h.name = '朱砂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '牛黄清心丸' AND h.name = '黄连';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '牛黄清心丸' AND h.name = '郁金';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '牛黄清心丸' AND h.name = '栀子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.75g'
FROM formula f, herb h
WHERE f.name = '牛黄清心丸' AND h.name = '牛黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '牛黄清心丸' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '白金丸' AND h.name = '郁金';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '白金丸' AND h.name = '白矾';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '50片）g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '银箔';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '朱砂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.3g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '冰片';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '安息香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '牛犀';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '雄黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.3g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '麝香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '50片g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '金箔';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '玳瑁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '琥珀';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.3g'
FROM formula f, herb h
WHERE f.name = '至宝丹' AND h.name = '牛黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '人参五味子汤' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '人参五味子汤' AND h.name = '麦门冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '人参五味子汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '人参五味子汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.4g'
FROM formula f, herb h
WHERE f.name = '人参五味子汤' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '人参五味子汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '养金汤' AND h.name = '杏仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '养金汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '养金汤' AND h.name = '沙参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '养金汤' AND h.name = '桑白皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '养金汤' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '养金汤' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '养金汤' AND h.name = '阿胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '养金汤' AND h.name = '白蜜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '甘露饮' AND h.name = '枇杷叶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '甘露饮' AND h.name = '石斛';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '甘露饮' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '甘露饮' AND h.name = '麦门冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '甘露饮' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '甘露饮' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '艾附暖宫丸' AND h.name = '吴茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '艾附暖宫丸' AND h.name = '艾叶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '艾附暖宫丸' AND h.name = '香附';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '艾附暖宫丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2g'
FROM formula f, herb h
WHERE f.name = '艾附暖宫丸' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '艾附暖宫丸' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '旋覆代赭汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '旋覆代赭汤' AND h.name = '代赭石';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4枚'
FROM formula f, herb h
WHERE f.name = '旋覆代赭汤' AND h.name = '大枣';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '旋覆代赭汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '旋覆代赭汤' AND h.name = '旋覆花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '旋覆代赭汤' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '旋覆代赭汤' AND h.name = '半夏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '三妙丸' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '三妙丸' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '三妙丸' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '不换金正气散' AND h.name = '半夏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '不换金正气散' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '不换金正气散' AND h.name = '厚朴';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '不换金正气散' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '不换金正气散' AND h.name = '藿香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '不换金正气散' AND h.name = '大枣';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '不换金正气散' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '不换金正气散' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '中焦宣痹汤' AND h.name = '半夏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '中焦宣痹汤' AND h.name = '滑石';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '中焦宣痹汤' AND h.name = '杏仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '中焦宣痹汤' AND h.name = '栀子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '中焦宣痹汤' AND h.name = '薏苡仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '中焦宣痹汤' AND h.name = '防己';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '中焦宣痹汤' AND h.name = '赤小豆皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '中焦宣痹汤' AND h.name = '晚蚕砂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '中焦宣痹汤' AND h.name = '连翘';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '二妙丸' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '二妙丸' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '二妙散' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '二妙散' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '二陈平胃散' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '二陈平胃散' AND h.name = '半夏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '二陈平胃散' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '二陈平胃散' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '二陈平胃散' AND h.name = '厚朴';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '二陈平胃散' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '五皮饮' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '五皮饮' AND h.name = '桑白皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '五皮饮' AND h.name = '大腹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '五皮饮' AND h.name = '茯苓皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '五皮饮' AND h.name = '生姜皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '栀子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '车前子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '甘草梢';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '木通';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '加味五淋散' AND h.name = '滑石';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '四妙散' AND h.name = '薏苡仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '四妙散' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '四妙散' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '四妙散' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '鸡血藤';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '赤芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '红花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '枳壳';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '前胡';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '独活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '羌活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '忍冬藤';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '散风除湿活血汤' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '木通散' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '木通散' AND h.name = '槟榔';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '木通散' AND h.name = '木通';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '木通散' AND h.name = '滑石';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '木通散' AND h.name = '枳壳';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '木通散' AND h.name = '冬葵子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '栝楼瞿麦丸' AND h.name = '天花粉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '栝楼瞿麦丸' AND h.name = '附子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '栝楼瞿麦丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '栝楼瞿麦丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '栝楼瞿麦丸' AND h.name = '瞿麦';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '泽泻汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '泽泻汤' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '甘姜苓术汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '甘姜苓术汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '甘姜苓术汤' AND h.name = '干姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '甘姜苓术汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '赤芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '青竹叶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '黄连';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '羌活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '决明子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '柴胡';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '大黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '升麻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '车前子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '栀子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '竹叶泻经汤' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '羌活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.1g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '枳壳';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '川乌';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.9g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '桂枝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.1g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.1g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '续断';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.1g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '穿山甲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.1g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '麻黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '羌活续断汤' AND h.name = '秦艽';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '羌活胜湿汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '羌活胜湿汤' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2g'
FROM formula f, herb h
WHERE f.name = '羌活胜湿汤' AND h.name = '蔓荆子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '羌活胜湿汤' AND h.name = '独活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '羌活胜湿汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '羌活胜湿汤' AND h.name = '羌活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '羌活胜湿汤' AND h.name = '藁本';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '猪苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '桂枝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '厚朴';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '大枣';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '胃苓汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '苓桂术甘汤' AND h.name = '桂枝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '苓桂术甘汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '苓桂术甘汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '苓桂术甘汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '槟榔';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '薄荷';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '桑白皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '木瓜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '木香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '砂仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '大腹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '紫苏叶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茯苓导水汤' AND h.name = '猪苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '茵陈五苓散' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '茵陈五苓散' AND h.name = '猪苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '茵陈五苓散' AND h.name = '桂枝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '茵陈五苓散' AND h.name = '茵陈';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '茵陈五苓散' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '茵陈五苓散' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '萆薢分清饮（原名萆薢分清散）' AND h.name = '益智仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '萆薢分清饮（原名萆薢分清散）' AND h.name = '乌药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '萆薢分清饮（原名萆薢分清散）' AND h.name = '石菖蒲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '萆薢分清饮（原名萆薢分清散）' AND h.name = '萆薢';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '薏苡仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '羌活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '川乌';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '桂枝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '独活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '7g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '薏苡仁汤' AND h.name = '麻黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '藿香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '桔梗';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '白芷';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '大腹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '紫苏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '厚朴';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '藿香正气散' AND h.name = '半夏曲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '栀子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '滑石';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '木通';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '厚朴';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '猪苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '灯心草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '除湿胃苓汤' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '神曲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '山楂肉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '砂仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '枳壳';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '麦芽';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '厚朴';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '香砂平胃散' AND h.name = '香附';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '麻黄连翘赤小豆汤' AND h.name = '连翘';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '麻黄连翘赤小豆汤' AND h.name = '大枣';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '麻黄连翘赤小豆汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '麻黄连翘赤小豆汤' AND h.name = '桑白皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '麻黄连翘赤小豆汤' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '麻黄连翘赤小豆汤' AND h.name = '杏仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '麻黄连翘赤小豆汤' AND h.name = '麻黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '麻黄连翘赤小豆汤' AND h.name = '赤小豆';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '一贯煎' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '一贯煎' AND h.name = '北沙参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '一贯煎' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '一贯煎' AND h.name = '川楝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '一贯煎' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '一贯煎' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '七味白术散' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '七味白术散' AND h.name = '木香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '七味白术散' AND h.name = '藿香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '七味白术散' AND h.name = '葛根';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '七味白术散' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '七味白术散' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '七味白术散' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '七味都气丸' AND h.name = '地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '七味都气丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '七味都气丸' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '七味都气丸' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '七味都气丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '七味都气丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '七味都气丸' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '250g'
FROM formula f, herb h
WHERE f.name = '七宝美髯丹' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '250g'
FROM formula f, herb h
WHERE f.name = '七宝美髯丹' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '250g'
FROM formula f, herb h
WHERE f.name = '七宝美髯丹' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '120g'
FROM formula f, herb h
WHERE f.name = '七宝美髯丹' AND h.name = '补骨脂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '500g'
FROM formula f, herb h
WHERE f.name = '七宝美髯丹' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '500g'
FROM formula f, herb h
WHERE f.name = '七宝美髯丹' AND h.name = '何首乌';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '250g'
FROM formula f, herb h
WHERE f.name = '七宝美髯丹' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '沉香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '薏苡仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '肉苁蓉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '柏子仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '车前子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '覆盆子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '酸枣仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '三仁五子丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '三才封髓丹' AND h.name = '砂仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '三才封髓丹' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '三才封髓丹' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '三才封髓丹' AND h.name = '天冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '三才封髓丹' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '三才封髓丹' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '车前子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '沙参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '玉竹';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '上下相资汤' AND h.name = '玄参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '两地汤' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '两地汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '两地汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '两地汤' AND h.name = '地骨皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '两地汤' AND h.name = '玄参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '两地汤' AND h.name = '阿胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4g'
FROM formula f, herb h
WHERE f.name = '举元煎' AND h.name = '升麻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '举元煎' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '举元煎' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '举元煎' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '举元煎' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '二仙汤' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '二仙汤' AND h.name = '巴戟肉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '二仙汤' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '二仙汤' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '二仙汤' AND h.name = '仙茅';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '二仙汤' AND h.name = '仙灵脾';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '二仙汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '五子衍宗丸' AND h.name = '覆盆子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '五子衍宗丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '五子衍宗丸' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '五子衍宗丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '五子衍宗丸' AND h.name = '车前子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '大枣';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '45g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '人参养荣汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.6g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.3g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '0.9g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.1g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.8g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.1g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.1g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '升麻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '人参益气汤' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '人参蛤蚧散（原名蛤蚧散）' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '人参蛤蚧散（原名蛤蚧散）' AND h.name = '杏仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '人参蛤蚧散（原名蛤蚧散）' AND h.name = '桑白皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '人参蛤蚧散（原名蛤蚧散）' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '人参蛤蚧散（原名蛤蚧散）' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '人参蛤蚧散（原名蛤蚧散）' AND h.name = '贝母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '人参蛤蚧散（原名蛤蚧散）' AND h.name = '蛤蚧';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '人参蛤蚧散（原名蛤蚧散）' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '何人饮' AND h.name = '何首乌';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '7.5g'
FROM formula f, herb h
WHERE f.name = '何人饮' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '何人饮' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '7.5g'
FROM formula f, herb h
WHERE f.name = '何人饮' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '何人饮' AND h.name = '煨姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2g'
FROM formula f, herb h
WHERE f.name = '保元汤' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '保元汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '保元汤' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '保元汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '保元汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '保阴煎' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '保阴煎' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '保阴煎' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '保阴煎' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '保阴煎' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '保阴煎' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '保阴煎' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '保阴煎' AND h.name = '续断';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '健固汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '健固汤' AND h.name = '巴戟天';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '健固汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '健固汤' AND h.name = '薏苡仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '健固汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '八物汤' AND h.name = '半夏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '八物汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '八物汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '八物汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '八物汤' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '八物汤' AND h.name = '熟地';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '八物汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '八物汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '八珍汤（原名八珍散）' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '八珍汤（原名八珍散）' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '八珍汤（原名八珍散）' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '八珍汤（原名八珍散）' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '八珍汤（原名八珍散）' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '八珍汤（原名八珍散）' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '八珍汤（原名八珍散）' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '八珍汤（原名八珍散）' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '六味地黄丸（原名地黄丸）' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '六味地黄丸（原名地黄丸）' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '六味地黄丸（原名地黄丸）' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '六味地黄丸（原名地黄丸）' AND h.name = '山萸肉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '六味地黄丸（原名地黄丸）' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '六味地黄丸（原名地黄丸）' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '养精种玉汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '养精种玉汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '养精种玉汤' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '养精种玉汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '养荣壮肾汤' AND h.name = '续断';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '养荣壮肾汤' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '养荣壮肾汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '养荣壮肾汤' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '养荣壮肾汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '养荣壮肾汤' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '养荣壮肾汤' AND h.name = '桑寄生';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '养荣壮肾汤' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '养荣壮肾汤' AND h.name = '独活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '内补丸' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '内补丸' AND h.name = '白蒺藜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '内补丸' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '内补丸' AND h.name = '桑螵蛸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '内补丸' AND h.name = '鹿茸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '内补丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '内补丸' AND h.name = '紫菀';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '内补丸' AND h.name = '潼蒺藜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '内补丸' AND h.name = '附片';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '内补丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '加减驻景丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '加减驻景丸' AND h.name = '车前子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '加减驻景丸' AND h.name = '花椒';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '加减驻景丸' AND h.name = '楮实子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '加减驻景丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '加减驻景丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '加减驻景丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '加减驻景丸' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味四君子汤' AND h.name = '白扁豆';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味四君子汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味四君子汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味四君子汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味四君子汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味四君子汤' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味四物汤' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味四物汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '加味四物汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '加味四物汤' AND h.name = '菊花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味四物汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '加味四物汤' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '加味四物汤' AND h.name = '蔓荆子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '加味四物汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '十全大补汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '十全大补汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '十全大补汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '十全大补汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '十全大补汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '十全大补汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '十全大补汤' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '十全大补汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '十全大补汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '十全大补汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '十珍汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '十珍汤' AND h.name = '党参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '十珍汤' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '十珍汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '十珍汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '十珍汤' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '十珍汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '十珍汤' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '十珍汤' AND h.name = '地骨皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '十珍汤' AND h.name = '天冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '十补丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '十补丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '十补丸' AND h.name = '炒山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '60g'
FROM formula f, herb h
WHERE f.name = '十补丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '十补丸' AND h.name = '鹿茸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '十补丸' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '十补丸' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '十补丸' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '十补丸' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '60g'
FROM formula f, herb h
WHERE f.name = '十补丸' AND h.name = '附子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '羌活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '柴胡';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '独活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '橘皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '黄连';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '半夏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '升阳益胃汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '升陷汤' AND h.name = '升麻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '升陷汤' AND h.name = '桔梗';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '升陷汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '升陷汤' AND h.name = '柴胡';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '升陷汤' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '参苓白术散' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '参苓白术散' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '参苓白术散' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '参苓白术散' AND h.name = '桔梗';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '参苓白术散' AND h.name = '白扁豆';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '参苓白术散' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '参苓白术散' AND h.name = '薏苡仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '参苓白术散' AND h.name = '莲子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '参苓白术散' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '参苓白术散' AND h.name = '砂仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '参蛤散' AND h.name = '蛤蚧';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '参蛤散' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '右归丸' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '右归丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '右归丸' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '右归丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '右归丸' AND h.name = '鹿角胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '右归丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '右归丸' AND h.name = '附片';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '右归丸' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '右归丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '右归丸' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '右归饮' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '右归饮' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '右归饮' AND h.name = '附片';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '右归饮' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '右归饮' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '右归饮' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '右归饮' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '右归饮' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '四物五子丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '四物五子丸' AND h.name = '地肤子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '四物五子丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '四物五子丸' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '四物五子丸' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '四物五子丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '四物五子丸' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '四物五子丸' AND h.name = '车前子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '四物五子丸' AND h.name = '覆盆子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '四物汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '四物汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '四物汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '四物汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '固阴煎' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '固阴煎' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '固阴煎' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '固阴煎' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '固阴煎' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '固阴煎' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '固阴煎' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '固阴煎' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '圣愈汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '圣愈汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '圣愈汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '圣愈汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '圣愈汤' AND h.name = '熟地';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '圣愈汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '地芝丸' AND h.name = '菊花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '地芝丸' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '地芝丸' AND h.name = '枳壳';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '地芝丸' AND h.name = '天冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '地黄饮' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '地黄饮' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '地黄饮' AND h.name = '僵蚕';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '地黄饮' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '地黄饮' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '地黄饮' AND h.name = '玄参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '地黄饮' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '地黄饮' AND h.name = '白蒺藜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '地黄饮' AND h.name = '红花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '地黄饮' AND h.name = '首乌';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '附子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '巴戟天';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '麦门冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '肉苁蓉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '官桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '石菖蒲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '石斛';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '地黄饮子' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '大补阴丸（原名大补丸）' AND h.name = '熟地';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '大补阴丸（原名大补丸）' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '大补阴丸（原名大补丸）' AND h.name = '龟板';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '大补阴丸（原名大补丸）' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '安冲汤' AND h.name = '龙骨';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '安冲汤' AND h.name = '茜草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '安冲汤' AND h.name = '续断';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '安冲汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '安冲汤' AND h.name = '海螵蛸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '安冲汤' AND h.name = '牡蛎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '安冲汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '安冲汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '安冲汤' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '定经汤' AND h.name = '柴胡';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '定经汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '定经汤' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '定经汤' AND h.name = '熟地';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '定经汤' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '定经汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '定经汤' AND h.name = '荆芥穗';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '定经汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '寿胎丸' AND h.name = '阿胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '寿胎丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '寿胎丸' AND h.name = '桑寄生';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '寿胎丸' AND h.name = '续断';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '小营煎' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '小营煎' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '小营煎' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '小营煎' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '小营煎' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '小营煎' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '左归丸' AND h.name = '熟地';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '左归丸' AND h.name = '龟甲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '左归丸' AND h.name = '枸杞';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '左归丸' AND h.name = '鹿胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '左归丸' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '左归丸' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '左归丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '左归丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '左归饮' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '左归饮' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '左归饮' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '左归饮' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '左归饮' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '左归饮' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '归肾丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '归肾丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '归肾丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '归肾丸' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '归肾丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '归肾丸' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '归肾丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '归肾丸' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '归芍六君子汤' AND h.name = '半夏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '归芍六君子汤' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '归芍六君子汤' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '归芍六君子汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '归芍六君子汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '归芍六君子汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '归芍六君子汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '归芍六君子汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '当归地黄饮' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '当归地黄饮' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '当归地黄饮' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4g'
FROM formula f, herb h
WHERE f.name = '当归地黄饮' AND h.name = '怀牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '当归地黄饮' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '当归地黄饮' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '当归地黄饮' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '当归散' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '当归散' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '当归散' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '当归散' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '当归散' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '当归活血饮' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '当归活血饮' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '当归活血饮' AND h.name = '羌活';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '当归活血饮' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '当归活血饮' AND h.name = '苍术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '当归活血饮' AND h.name = '薄荷';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '当归活血饮' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '当归活血饮' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '当归活血饮' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '当归补血汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '当归补血汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '慎柔养真汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '慎柔养真汤' AND h.name = '莲子肉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '慎柔养真汤' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '慎柔养真汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '慎柔养真汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '慎柔养真汤' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '慎柔养真汤' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '慎柔养真汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '慎柔养真汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '慎柔养真汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '茯神';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '赤石脂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '25g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '巴戟天';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '肉苁蓉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '无比山药丸' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '明目地黄丸' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '明目地黄丸' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '明目地黄丸' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '明目地黄丸' AND h.name = '柴胡';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '明目地黄丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '明目地黄丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '明目地黄丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '明目地黄丸' AND h.name = '茯神';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '明目地黄丸' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '明目地黄丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '菊花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '山萸肉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '石决明';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '明目地黄汤' AND h.name = '蒺藜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '百部';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '天冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '沙参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '三七';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '60g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '桑叶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '阿胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '60g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '菊花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '川贝母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '月华丸' AND h.name = '獭肝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '杜仲丸' AND h.name = '龟板';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '杜仲丸' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '杜仲丸' AND h.name = '补骨脂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '杜仲丸' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '杜仲丸' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '杜仲丸' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '杜仲丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '杜仲丸' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '杜仲丸' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '杜仲丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '桃红四物汤' AND h.name = '桃仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '桃红四物汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '桃红四物汤' AND h.name = '红花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '16g'
FROM formula f, herb h
WHERE f.name = '桃红四物汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '桃红四物汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '桃红四物汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '止泪补肝散' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '止泪补肝散' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '止泪补肝散' AND h.name = '木贼';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '止泪补肝散' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '止泪补肝散' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '止泪补肝散' AND h.name = '蒺藜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '止泪补肝散' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '止泪补肝散' AND h.name = '夏枯草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '川椒';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '鹿角霜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '毓麟珠' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '河车大造丸' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '河车大造丸' AND h.name = '紫河车';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '河车大造丸' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '河车大造丸' AND h.name = '天冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '河车大造丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '河车大造丸' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '河车大造丸' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '河车大造丸' AND h.name = '龟甲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '济生肾气丸' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '济生肾气丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '济生肾气丸' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '济生肾气丸' AND h.name = '车前子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '济生肾气丸' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '济生肾气丸' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '济生肾气丸' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '济生肾气丸' AND h.name = '附子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '济生肾气丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '济生肾气丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '温肺止流丹' AND h.name = '荆芥';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '温肺止流丹' AND h.name = '鱼脑石';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '温肺止流丹' AND h.name = '桔梗';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '温肺止流丹' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '温肺止流丹' AND h.name = '诃子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '温肺止流丹' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '温肺止流丹' AND h.name = '细辛';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '温胞饮' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1g'
FROM formula f, herb h
WHERE f.name = '温胞饮' AND h.name = '附子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '温胞饮' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '温胞饮' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '温胞饮' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '温胞饮' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '温胞饮' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '温胞饮' AND h.name = '芡实';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '温胞饮' AND h.name = '巴戟天';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '温胞饮' AND h.name = '补骨脂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '滋血汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '滋血汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '滋血汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '滋血汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '滋血汤' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '8g'
FROM formula f, herb h
WHERE f.name = '滋血汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '滋血汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '滋血汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '蒺藜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '青葙子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '木贼';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '蝉蜕';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '菊花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '玄参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '滋阴退翳汤' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '柴胡';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '滋阴降火汤' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '地骨皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.4g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.4g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.4g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '柴胡';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.4g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '贝母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.4g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.4g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.4g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '黄芩';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '滋阴除湿汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '炙甘草汤（又名复脉汤）' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '炙甘草汤（又名复脉汤）' AND h.name = '大枣';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '炙甘草汤（又名复脉汤）' AND h.name = '麻仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '炙甘草汤（又名复脉汤）' AND h.name = '麦门冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '50g'
FROM formula f, herb h
WHERE f.name = '炙甘草汤（又名复脉汤）' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '炙甘草汤（又名复脉汤）' AND h.name = '桂枝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '炙甘草汤（又名复脉汤）' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '炙甘草汤（又名复脉汤）' AND h.name = '阿胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '炙甘草汤（又名复脉汤）' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '独参汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '玉泉丸' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '玉泉丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '玉泉丸' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '玉泉丸' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '玉泉丸' AND h.name = '天花粉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '玉泉丸' AND h.name = '乌梅';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '玉泉丸' AND h.name = '葛根';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '玉泉丸' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '玉烛散' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '玉烛散' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '玉烛散' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '玉烛散' AND h.name = '大黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '玉烛散' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '玉烛散' AND h.name = '芒硝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '玉烛散' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '生姜甘草汤' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '生姜甘草汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '生姜甘草汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '生姜甘草汤' AND h.name = '大枣';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '生脉地黄汤' AND h.name = '地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '生脉地黄汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '生脉地黄汤' AND h.name = '丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '生脉地黄汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '生脉地黄汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '生脉地黄汤' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '生脉地黄汤' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '生脉地黄汤' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '生脉地黄汤' AND h.name = '山萸肉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '生蒲黄汤' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '生蒲黄汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '生蒲黄汤' AND h.name = '丹参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '生蒲黄汤' AND h.name = '生蒲黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '生蒲黄汤' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '生蒲黄汤' AND h.name = '荆芥炭';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '生蒲黄汤' AND h.name = '墨旱莲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '生蒲黄汤' AND h.name = '郁金';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '益气导溺汤' AND h.name = '扁豆';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '益气导溺汤' AND h.name = '升麻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '益气导溺汤' AND h.name = '党参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '益气导溺汤' AND h.name = '通草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '益气导溺汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '益气导溺汤' AND h.name = '桂枝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '益气导溺汤' AND h.name = '桔梗';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '益气导溺汤' AND h.name = '乌药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '益气导溺汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '益气聪明汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '益气聪明汤' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '益气聪明汤' AND h.name = '葛根';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '益气聪明汤' AND h.name = '升麻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '益气聪明汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '益气聪明汤' AND h.name = '蔓荆子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '益气聪明汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '益气聪明汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '益肾调经汤' AND h.name = '续断';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '益肾调经汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '益肾调经汤' AND h.name = '艾叶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '益肾调经汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '益肾调经汤' AND h.name = '乌药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '益肾调经汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '益肾调经汤' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '益肾调经汤' AND h.name = '益母草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '益肾调经汤' AND h.name = '巴戟天';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '知柏地黄丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '知柏地黄丸' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '知柏地黄丸' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '知柏地黄丸' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '知柏地黄丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '知柏地黄丸' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '知柏地黄丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '知柏地黄丸' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '肉苁蓉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '水牛角';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '生地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '草决明';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '蒺藜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '天门冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '麦门冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '杏仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '青葙子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '石斛';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '黄连';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '羚羊角';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '菊花';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '12枳壳';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '石斛夜光丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '耳聋左慈丸' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '耳聋左慈丸' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '耳聋左慈丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.5g'
FROM formula f, herb h
WHERE f.name = '耳聋左慈丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '耳聋左慈丸' AND h.name = '石菖蒲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '耳聋左慈丸' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '耳聋左慈丸' AND h.name = '磁石';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '耳聋左慈丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '耳聋左慈丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '肠宁汤' AND h.name = '续断';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '肠宁汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '肠宁汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '肠宁汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '肠宁汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '肠宁汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '肠宁汤' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '肠宁汤' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '肠宁汤' AND h.name = '阿胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '肾气丸（又名《金匮》肾气丸、崔氏八味丸）' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '肾气丸（又名《金匮》肾气丸、崔氏八味丸）' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '肾气丸（又名《金匮》肾气丸、崔氏八味丸）' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '肾气丸（又名《金匮》肾气丸、崔氏八味丸）' AND h.name = '附子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '肾气丸（又名《金匮》肾气丸、崔氏八味丸）' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '肾气丸（又名《金匮》肾气丸、崔氏八味丸）' AND h.name = '桂枝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '肾气丸（又名《金匮》肾气丸、崔氏八味丸）' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '肾气丸（又名《金匮》肾气丸、崔氏八味丸）' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '胎元饮' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '胎元饮' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '胎元饮' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '胎元饮' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '胎元饮' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '胎元饮' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '胎元饮' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '胎元饮' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '荆穗四物汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '荆穗四物汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '荆穗四物汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '荆穗四物汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '荆穗四物汤' AND h.name = '荆芥穗';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '荆穗四物汤' AND h.name = '防风';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '虎潜丸' AND h.name = '虎骨';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '虎潜丸' AND h.name = '干姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '虎潜丸' AND h.name = '龟甲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '虎潜丸' AND h.name = '锁阳';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '虎潜丸' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '虎潜丸' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '虎潜丸' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '虎潜丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '虎潜丸' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补中益气汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补中益气汤' AND h.name = '橘皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补中益气汤' AND h.name = '升麻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '补中益气汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补中益气汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补中益气汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补中益气汤' AND h.name = '柴胡';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '补中益气汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '120g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '熟地';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '240g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '龟板';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '60g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '45g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '90g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '120g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '45g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '45g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '酸枣仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '45g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '45g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '500g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '鹿角';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '河车';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '45g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '90g'
FROM formula f, herb h
WHERE f.name = '补天大造丸' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '补气运脾汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补气运脾汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补气运脾汤' AND h.name = '半夏曲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补气运脾汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '补气运脾汤' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补气运脾汤' AND h.name = '生姜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '补气运脾汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.4g'
FROM formula f, herb h
WHERE f.name = '补气运脾汤' AND h.name = '砂仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补气运脾汤' AND h.name = '大枣';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '1.2g'
FROM formula f, herb h
WHERE f.name = '补气运脾汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补肝汤' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补肝汤' AND h.name = '川芎';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补肝汤' AND h.name = '酸枣仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '补肝汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '补肝汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补肝汤' AND h.name = '木瓜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '补肝汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肺汤' AND h.name = '紫菀';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '补肺汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补肺汤' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '补肺汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肺汤' AND h.name = '桑白皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肺汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '巴戟天';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '25g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '阿胶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '大枣';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '砂仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '续断';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '党参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '鹿角霜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '补肾固冲丸' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '酸枣仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '黄柏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '竹叶';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '泽泻';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '知母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '玄参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '熟地';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '山萸肉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '龟板';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '补肾地黄汤' AND h.name = '桑螵蛸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '蛇床子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '韭菜子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '淫羊藿';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '仙茅';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '肉苁蓉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '25g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '18g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '附子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '巴戟天';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '25g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '鹿茸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '赞育丹' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '续断';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '牛膝';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '肉苁蓉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '石菖蒲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '小茴香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '山茱萸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '巴戟天';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '楮实子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '还少丹' AND h.name = '山药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '通乳丹' AND h.name = '桔梗';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '通乳丹' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '500g'
FROM formula f, herb h
WHERE f.name = '通乳丹' AND h.name = '猪蹄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '60g'
FROM formula f, herb h
WHERE f.name = '通乳丹' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '通乳丹' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '通乳丹' AND h.name = '木通';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '通乳丹' AND h.name = '麦冬';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '24g'
FROM formula f, herb h
WHERE f.name = '青蛾丸' AND h.name = '补骨脂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '50g'
FROM formula f, herb h
WHERE f.name = '青蛾丸' AND h.name = '杜仲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '青蛾丸' AND h.name = '大蒜';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '20g'
FROM formula f, herb h
WHERE f.name = '青蛾丸' AND h.name = '胡桃';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '酸枣仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '120g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '合欢树根皮合欢树…';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '乌药';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '远志';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '香附';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '木香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '贝母';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '10g'
FROM formula f, herb h
WHERE f.name = '顺气归脾丸' AND h.name = '茯神';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '顺经汤' AND h.name = '荆芥';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '顺经汤' AND h.name = '熟地黄';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '顺经汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '顺经汤' AND h.name = '牡丹皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '顺经汤' AND h.name = '当归';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '顺经汤' AND h.name = '白芍';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '顺经汤' AND h.name = '沙参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.5g'
FROM formula f, herb h
WHERE f.name = '香砂六君子汤' AND h.name = '陈皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2g'
FROM formula f, herb h
WHERE f.name = '香砂六君子汤' AND h.name = '木香';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '香砂六君子汤' AND h.name = '白术';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '6g'
FROM formula f, herb h
WHERE f.name = '香砂六君子汤' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2.5g'
FROM formula f, herb h
WHERE f.name = '香砂六君子汤' AND h.name = '砂仁';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '香砂六君子汤' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '3g'
FROM formula f, herb h
WHERE f.name = '香砂六君子汤' AND h.name = '半夏';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2g'
FROM formula f, herb h
WHERE f.name = '香砂六君子汤' AND h.name = '炙甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '附子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '龙骨';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '菟丝子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '莲肉';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '桑螵蛸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '茯苓';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '15g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '鹿茸';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '补骨脂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '桑皮';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '肉桂';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '12g'
FROM formula f, herb h
WHERE f.name = '鹿茸补涩丸' AND h.name = '五味子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '30g'
FROM formula f, herb h
WHERE f.name = '黄芪六一汤' AND h.name = '黄芪';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5g'
FROM formula f, herb h
WHERE f.name = '黄芪六一汤' AND h.name = '甘草';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '450g'
FROM formula f, herb h
WHERE f.name = '龟鹿二仙胶' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '2500g'
FROM formula f, herb h
WHERE f.name = '龟鹿二仙胶' AND h.name = '龟板';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '900g'
FROM formula f, herb h
WHERE f.name = '龟鹿二仙胶' AND h.name = '枸杞子';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '5000g'
FROM formula f, herb h
WHERE f.name = '龟鹿二仙胶' AND h.name = '鹿角';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '50g'
FROM formula f, herb h
WHERE f.name = '龟鹿二仙膏' AND h.name = '鹿角';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '4.5g'
FROM formula f, herb h
WHERE f.name = '龟鹿二仙膏' AND h.name = '人参';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '25g'
FROM formula f, herb h
WHERE f.name = '龟鹿二仙膏' AND h.name = '龟甲';
INSERT INTO formula_herb (formula_id, herb_id, dosage)
SELECT f.id, h.id, '9g'
FROM formula f, herb h
WHERE f.name = '龟鹿二仙膏' AND h.name = '枸杞子';
