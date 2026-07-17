-- ============================================================
-- 中药材基础数据导入
-- 来源: 中医医疗系统 + 标注二级分类后的方剂表.xlsx
-- ============================================================

USE tcm_hospital;

-- 清空已有数据（避免重复导入）
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE herb;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('12枳壳', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('三七', '止血药', '温', '甘、微苦', '肝、胃', 3, 9, 'g', 0, '散瘀止血，消肿定痛', '咯血，吐血，衄血，便血，跌打损伤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('三棱', '活血化瘀药', '平', '辛、苦', '肝、脾', 3, 10, 'g', 0, '破血行气，消积止痛', '癥瘕痞块，瘀血经闭');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('丹参', '活血化瘀药', '微寒', '苦', '心、肝', 10, 15, 'g', 0, '活血调经，祛瘀止痛，凉血消痈', '月经不调，经闭痛经，疮疡肿痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('丹皮', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('乌梅', '收涩药', '平', '酸、涩', '肝、脾、肺、大肠', 6, 12, 'g', 0, '敛肺止咳，涩肠止泻，安蛔止痛', '肺虚久咳，久泻久痢，蛔厥腹痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('乌药', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('乳香', '活血化瘀药', '温', '辛、苦', '心、肝、脾', 3, 10, 'g', 0, '活血定痛，消肿生肌', '胸痹心痛，胃脘疼痛，跌打损伤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('五味子', '收涩药', '温', '酸、甘', '肺、心、肾', 2, 6, 'g', 0, '收敛固涩，益气生津，补肾宁心', '久嗽虚喘，梦遗滑精，遗尿尿频');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('人参', '补虚药', '微温', '甘、微苦', '脾、肺、心、肾', 3, 9, 'g', 0, '大补元气，复脉固脱，补脾益肺', '体虚欲脱，肢冷脉微，脾虚食少');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('仙灵脾', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('仙茅', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('代赭石', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('何首乌', '补虚药', '微温', '苦、甘、涩', '肝、肾', 3, 6, 'g', 1, '制用补肝肾益精血，生用解毒截疟', '血虚萎黄，须发早白，久疟');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('僵蚕', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('党参', '补虚药', '平', '甘', '脾、肺', 9, 30, 'g', 0, '补中益气，健脾益肺', '脾肺虚弱，气短心悸，食少便溏');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('全蝎', '平肝息风药', '平', '辛', '肝', 2, 5, 'g', 1, '息风镇痉，通络止痛，攻毒散结', '痉挛抽搐，疮疡肿毒');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('冬葵子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('冰片', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('决明子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('前胡', '化痰止咳平喘药', '微寒', '苦、辛', '肺', 3, 10, 'g', 0, '降气化痰，散风清热', '痰热喘满，咯痰黄稠');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('北沙参', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('升麻', '解表药', '微寒', '辛、微甘', '肺、脾、胃、大肠', 3, 10, 'g', 0, '发表透疹，清热解毒，升举阳气', '风热感冒，麻疹不透，齿痛口疮');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('半夏', '化痰止咳平喘药', '温', '辛', '脾、胃、肺', 3, 10, 'g', 1, '燥湿化痰，降逆止呕，消痞散结', '湿痰寒痰，呕吐，心下痞');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('半夏曲', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('厚朴', '化湿药', '温', '苦、辛', '脾、胃、肺、大肠', 3, 10, 'g', 0, '燥湿消痰，下气除满', '湿阻中焦，食积气滞');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('合欢树根皮合欢树…', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('吴茱萸', '温里药', '热', '辛、苦', '肝、脾、胃、肾', 1, 5, 'g', 1, '散寒止痛，降逆止呕，助阳止泻', '寒凝疼痛，胃寒呕吐');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('地榆', '止血药', '微寒', '苦、酸、涩', '肝、大肠', 10, 15, 'g', 0, '凉血止血，解毒敛疮', '便血，痔血，水火烫伤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('地肤子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('地骨皮', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('地黄', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('墨旱莲', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('夏枯草', '清热药', '寒', '辛、苦', '肝、胆', 9, 15, 'g', 0, '清热泻火，明目，散结消肿', '目赤肿痛，头痛眩晕，瘰疬瘿瘤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('大枣', '补虚药', '温', '甘', '脾、胃、心', 6, 15, 'g', 0, '补中益气，养血安神', '脾虚食少，乏力便溏，妇人脏躁');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('大腹皮', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('大蒜', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('大黄', '泻下药', '寒', '苦', '脾、胃、大肠、肝、心包', 3, 15, 'g', 0, '泻下攻积，清热泻火，凉血解毒', '积滞便秘，热毒疮疡，瘀血证');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('天冬', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('天南星', '化痰止咳平喘药', '温', '苦、辛', '肺、肝、脾', 3, 9, 'g', 1, '燥湿化痰，祛风解痉', '顽痰咳嗽，风痰眩晕');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('天台乌药', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('天竺黄', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('天花粉', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('天门冬', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('天麻', '平肝息风药', '平', '甘', '肝', 3, 10, 'g', 0, '息风止痉，平抑肝阳，祛风通络', '眩晕头痛，惊痫抽搐');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('姜黄', '活血化瘀药', '温', '辛、苦', '肝、脾', 3, 10, 'g', 0, '破血行气，通经止痛', '胸胁刺痛，胸痹心痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('安息香', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('官桂', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('小茴香', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('小麦', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('山楂', '消食药', '微温', '酸、甘', '脾、胃、肝', 10, 15, 'g', 0, '消食健胃，行气散瘀', '饮食积滞，泻痢腹痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('山楂肉', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('山茱萸', '收涩药', '微温', '酸、涩', '肝、肾', 6, 12, 'g', 0, '补益肝肾，收涩固脱', '眩晕耳鸣，腰膝酸痛，阳痿遗精');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('山药', '补虚药', '平', '甘', '脾、肺、肾', 15, 30, 'g', 0, '补脾养胃，生津益肺，补肾涩精', '脾虚食少，久泻不止，肺虚喘咳');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('山萸肉', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('川乌', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('川椒', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('川楝子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('川芎', '活血化瘀药', '温', '辛', '肝、胆、心包', 3, 10, 'g', 0, '活血行气，祛风止痛', '血瘀气滞诸痛，头痛，风湿痹痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('川贝母', '化痰止咳平喘药', '微寒', '苦、甘', '肺、心', 3, 10, 'g', 0, '清热化痰，润肺止咳', '肺热燥咳，干咳少痰');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('巴戟天', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('巴戟肉', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('干姜', '温里药', '热', '辛', '脾、胃、肾、心、肺', 3, 10, 'g', 0, '温中散寒，回阳通脉，温肺化饮', '脘腹冷痛，呕吐泄泻，亡阳证');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('延胡索', '活血化瘀药', '温', '辛、苦', '心、肝、脾', 3, 10, 'g', 0, '活血，行气，止痛', '气血瘀滞诸痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('当归', '补虚药', '温', '甘、辛', '肝、心、脾', 6, 12, 'g', 0, '补血活血，调经止痛，润肠通便', '血虚萎黄，眩晕心悸，月经不调');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('忍冬藤', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('怀牛膝', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('扁豆', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('旋覆花', '化痰止咳平喘药', '微温', '苦、辛、咸', '肺、脾、胃、大肠', 3, 10, 'g', 0, '降气，消痰，行水，止呕', '风寒咳嗽，痰饮蓄结');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('昆布', '化痰止咳平喘药', '寒', '咸', '肝、胃、肾', 6, 12, 'g', 0, '消痰软坚散结，利水消肿', '瘿瘤，瘰疬，睾丸肿痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('晚蚕砂', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('木瓜', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('木贼', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('木通', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('木香', '理气药', '温', '辛、苦', '脾、胃、大肠、胆、三焦', 3, 10, 'g', 0, '行气止痛，健脾消食', '脘腹胀痛，食积不消');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('朱砂', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('杏仁', '化痰止咳平喘药', '微温', '苦', '肺、大肠', 3, 10, 'g', 1, '降气止咳平喘，润肠通便', '咳嗽气喘，肠燥便秘');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('杜仲', '补虚药', '温', '甘', '肝、肾', 10, 15, 'g', 0, '补肝肾，强筋骨，安胎', '肾虚腰痛，筋骨无力，妊娠漏血');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('板蓝根', '清热药', '寒', '苦', '心、胃', 10, 15, 'g', 0, '清热解毒，凉血利咽', '温疫时毒，发热咽痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('枇杷叶', '化痰止咳平喘药', '微寒', '苦', '肺、胃', 6, 10, 'g', 0, '清肺止咳，降逆止呕', '肺热咳嗽，气逆喘急');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('枯矾', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('枳壳', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('枳实', '理气药', '微寒', '苦、辛、酸', '脾、胃、大肠', 3, 10, 'g', 0, '破气消积，化痰散痞', '积滞内停，痞满胀痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('枸杞', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('枸杞子', '补虚药', '平', '甘', '肝、肾', 6, 12, 'g', 0, '滋补肝肾，益精明目', '虚劳精亏，腰膝酸痛，眩晕耳鸣');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('柏子仁', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('柴胡', '解表药', '微寒', '辛、苦', '肝、胆', 3, 10, 'g', 0, '疏散退热，疏肝解郁，升举阳气', '感冒发热，寒热往来，胸胁胀痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('栀子', '清热药', '寒', '苦', '心、肺、三焦', 6, 10, 'g', 0, '泻火除烦，清热利湿，凉血解毒', '热病心烦，湿热黄疸，血热吐衄');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('桂枝', '解表药', '温', '辛、甘', '心、肺、膀胱', 3, 10, 'g', 0, '发汗解肌，温通经脉，助阳化气', '风寒感冒，寒凝血滞诸痛，痰饮，蓄水证');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('桃仁', '活血化瘀药', '平', '苦、甘', '心、肝、大肠', 5, 10, 'g', 1, '活血祛瘀，润肠通便', '经闭痛经，癥瘕痞块，肠燥便秘');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('桑叶', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('桑寄生', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('桑白皮', '化痰止咳平喘药', '寒', '甘', '肺', 6, 12, 'g', 0, '泻肺平喘，利水消肿', '肺热喘咳，水肿胀满');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('桑皮', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('桑螵蛸', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('桔梗', '化痰止咳平喘药', '平', '苦、辛', '肺', 3, 10, 'g', 0, '宣肺祛痰，利咽排脓', '咳嗽痰多，咽喉肿痛，肺痈');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('楮实子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('槟榔', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('橘皮', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('款冬花', '化痰止咳平喘药', '温', '辛', '肺', 5, 10, 'g', 0, '润肺下气，止咳化痰', '咳嗽气喘');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('水牛角', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('沉香', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('沙参', '补虚药', '微寒', '甘、微苦', '肺、胃', 10, 15, 'g', 0, '养阴清肺，益胃生津', '肺热燥咳，阴虚劳嗽，胃阴不足');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('沙苑子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('没药', '活血化瘀药', '平', '辛、苦', '心、肝、脾', 3, 10, 'g', 0, '散瘀定痛，消肿生肌', '胸痹心痛，胃脘疼痛，跌打损伤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('河车', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('泽泻', '利水渗湿药', '寒', '甘、淡', '肾、膀胱', 6, 10, 'g', 0, '利水渗湿，泄热', '小便不利，水肿胀满');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('海藻', '化痰止咳平喘药', '寒', '苦、咸', '肝、胃、肾', 6, 12, 'g', 0, '消痰软坚散结，利水消肿', '瘿瘤，瘰疬，睾丸肿痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('海螵蛸', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('淡竹叶', '清热药', '寒', '甘、淡', '心、胃、小肠', 6, 10, 'g', 0, '清热泻火，除烦利尿', '热病烦渴，口疮尿赤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('淡豆豉', '解表药', '凉', '辛、甘、微苦', '肺、胃', 6, 12, 'g', 0, '解表，除烦', '感冒，寒热头痛，心烦');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('淫羊藿', '补虚药', '温', '辛、甘', '肝、肾', 6, 10, 'g', 0, '补肾阳，强筋骨，祛风湿', '阳痿遗精，筋骨痿软，风湿痹痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('滑石', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('潼蒺藜', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('灯心草', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('炒山药', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('炙甘草', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('煅龙骨', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('煨姜', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('熟地', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('熟地黄', '补虚药', '微温', '甘', '肝、肾', 10, 30, 'g', 0, '补血滋阴，益精填髓', '血虚萎黄，心悸怔忡，月经不调');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('牛犀', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('牛膝', '活血化瘀药', '平', '苦、甘、酸', '肝、肾', 6, 15, 'g', 0, '逐瘀通经，补肝肾强筋骨', '经闭痛经，腰膝酸痛，筋骨无力');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('牛蒡子', '解表药', '寒', '辛、苦', '肺、胃', 6, 12, 'g', 0, '疏散风热，宣肺祛痰，利咽透疹', '风热感冒，咳嗽痰多，咽喉肿痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('牛黄', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('牡丹皮', '清热药', '微寒', '苦、辛', '心、肝、肾', 6, 12, 'g', 0, '清热凉血，活血化瘀', '热入营血，温毒发斑，跌打损伤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('牡蛎', '安神药', '微寒', '咸', '肝、胆、肾', 10, 30, 'g', 0, '重镇安神，潜阳补阴，软坚散结', '惊悸失眠，眩晕耳鸣');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('犀角', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('独活', '祛风湿药', '微温', '辛、苦', '肾、膀胱', 3, 10, 'g', 0, '祛风湿，止痛，解表', '风寒湿痹，腰膝疼痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('猪苓', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('猪蹄', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('獭肝', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('玄参', '清热药', '微寒', '甘、苦、咸', '肺、胃、肾', 10, 15, 'g', 0, '清热凉血，泻火解毒，滋阴', '温邪入营，烦躁谵语，阴虚火旺');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('玉竹', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('玳瑁', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('珍珠母', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('琥珀', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('瓜蒌', '化痰止咳平喘药', '寒', '甘、微苦', '肺、胃、大肠', 10, 20, 'g', 0, '清热化痰，宽胸散结，润肠通便', '痰热咳嗽，胸痹心痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('甘草', '补虚药', '平', '甘', '心、肺、脾、胃', 2, 10, 'g', 0, '补脾益气，清热解毒，祛痰止咳', '脾胃虚弱，倦怠乏力，心悸气短');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('甘草梢', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('甘遂', '泻下药', '寒', '苦', '肺、肾、大肠', 0.5, 1, 'g', 1, '泻水逐饮，消肿散结', '水肿胀满，胸腹积水');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('生地黄', '清热药', '寒', '甘、苦', '心、肝、肾', 10, 15, 'g', 0, '清热凉血，养阴生津', '热入营血，舌绛烦渴，阴虚内热');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('生姜', '解表药', '微温', '辛', '肺、脾、胃', 3, 10, 'g', 0, '解表散寒，温中止呕，温肺止咳', '风寒感冒，脾胃寒证，胃寒呕吐');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('生姜皮', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('生蒲黄', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('白前', '化痰止咳平喘药', '微温', '辛、苦', '肺', 3, 10, 'g', 0, '降气，消痰，止咳', '肺气壅实，咳嗽痰多');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('白扁豆', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('白术', '补虚药', '温', '甘、苦', '脾、胃', 6, 12, 'g', 0, '健脾益气，燥湿利水，止汗', '脾虚食少，腹胀泄泻，痰饮眩悸');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('白矾', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('白芍', '补虚药', '微寒', '苦、酸', '肝、脾', 6, 15, 'g', 0, '养血调经，敛阴止汗，柔肝止痛', '血虚萎黄，月经不调，自汗盗汗');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('白芷', '解表药', '温', '辛', '肺、胃、大肠', 3, 10, 'g', 0, '解表散寒，祛风止痛，通鼻窍', '风寒感冒，头痛，鼻塞');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('白茅根', '止血药', '寒', '甘', '肺、胃、膀胱', 10, 30, 'g', 0, '凉血止血，清热利尿', '血热吐血，衄血，尿血');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('白蒺藜', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('白蜜', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('百合', '补虚药', '微寒', '甘', '心、肺', 6, 12, 'g', 0, '养阴润肺，清心安神', '阴虚燥咳，劳嗽咳血，虚烦惊悸');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('百部', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('益智仁', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('益母草', '活血化瘀药', '微寒', '苦、辛', '肝、心包、膀胱', 10, 30, 'g', 0, '活血调经，利尿消肿', '月经不调，痛经经闭，恶露不尽');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('瞿麦', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('知母', '清热药', '寒', '苦、甘', '肺、胃、肾', 6, 12, 'g', 0, '清热泻火，滋阴润燥', '热病烦渴，肺热燥咳');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('石决明', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('石斛', '补虚药', '微寒', '甘', '胃、肾', 6, 12, 'g', 0, '益胃生津，滋阴清热', '热病津伤，口干烦渴，胃阴不足');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('石膏', '清热药', '大寒', '辛、甘', '肺、胃', 15, 60, 'g', 0, '清热泻火，除烦止渴', '壮热烦渴，肺热喘咳');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('石菖蒲', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('砂仁', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('磁石', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('神曲', '消食药', '温', '甘、辛', '脾、胃', 6, 15, 'g', 0, '消食和胃', '饮食积滞');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('禹余粮', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('秦艽', '祛风湿药', '平', '辛、苦', '胃、肝、胆', 3, 10, 'g', 0, '祛风湿，通络止痛，退虚热', '风湿痹痛，筋脉拘挛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('穿山甲', '活血化瘀药', '微寒', '咸', '肝、胃', 3, 10, 'g', 0, '活血消癥，通经下乳，消肿排脓', '癥瘕痞块，瘀血经闭');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('竹叶', '清热药', '寒', '甘、辛、淡', '心、胃、小肠', 6, 15, 'g', 0, '清热泻火，除烦利尿', '热病烦渴，小便短赤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('竹茹', '化痰止咳平喘药', '微寒', '甘', '肺、胃、心、胆', 6, 10, 'g', 0, '清热化痰，除烦止呕', '痰热咳嗽，胆火挟痰');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('粳米', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('紫河车', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('紫苏', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('紫苏叶', '解表药', '温', '辛', '肺、脾', 5, 10, 'g', 0, '解表散寒，行气宽中', '风寒感冒，脾胃气滞');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('紫菀', '化痰止咳平喘药', '温', '辛、苦', '肺', 5, 10, 'g', 0, '润肺下气，消痰止咳', '咳嗽痰多');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('红花', '活血化瘀药', '温', '辛', '心、肝', 3, 10, 'g', 0, '活血通经，散瘀止痛', '经闭，痛经，跌打损伤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('细辛', '解表药', '温', '辛', '肺、肾', 1, 3, 'g', 1, '解表散寒，祛风止痛，通窍', '风寒感冒，头痛，牙痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('续断', '补虚药', '微温', '苦、辛', '肝、肾', 9, 15, 'g', 0, '补肝肾，强筋骨，续折伤', '腰膝酸软，风湿痹痛，跌打损伤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('罂粟壳', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('羌活', '解表药', '温', '辛、苦', '膀胱、肾', 3, 10, 'g', 0, '解表散寒，祛风胜湿，止痛', '风寒感冒，风寒湿痹');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('羚羊角', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('肉桂', '温里药', '大热', '辛、甘', '肾、脾、心、肝', 1, 5, 'g', 0, '补火助阳，散寒止痛，温通经脉', '阳痿宫冷，腰膝冷痛，心腹冷痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('肉苁蓉', '补虚药', '温', '甘、咸', '肾、大肠', 10, 15, 'g', 0, '补肾阳，益精血，润肠通便', '阳痿不孕，腰膝酸软，肠燥便秘');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('肉豆蔻', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('胡桃', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('艾叶', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('芒硝', '泻下药', '寒', '咸、苦', '胃、大肠', 10, 15, 'g', 0, '泻下攻积，润燥软坚，清热消肿', '实热积滞，大便燥结');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('芡实', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('花椒', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('苍术', '化湿药', '温', '辛、苦', '脾、胃、肝', 5, 10, 'g', 0, '燥湿健脾，祛风散寒', '湿阻中焦，风湿痹证');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('茜草', '止血药', '寒', '苦', '肝', 6, 10, 'g', 0, '凉血，祛瘀，止血，通经', '吐血，衄血，崩漏，经闭瘀阻');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('茯神', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('茯苓', '利水渗湿药', '平', '甘、淡', '心、脾、肾', 10, 15, 'g', 0, '利水渗湿，健脾宁心', '水肿尿少，痰饮眩悸，脾虚食少');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('茯苓皮', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('茵陈', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('荆芥', '解表药', '微温', '辛', '肺、肝', 5, 10, 'g', 0, '祛风解表，透疹消疮', '外感表证，麻疹不透，疮疡初起');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('荆芥炭', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('荆芥穗', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('草决明', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('莪术', '活血化瘀药', '温', '辛、苦', '肝、脾', 3, 10, 'g', 0, '破血行气，消积止痛', '癥瘕痞块，瘀血经闭');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('莲子', '收涩药', '平', '甘、涩', '脾、肾、心', 6, 15, 'g', 0, '补脾止泻，止带，益肾涩精', '脾虚泄泻，带下，遗精滑精');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('莲子肉', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('莲肉', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('菊花', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('菖蒲', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('菟丝子', '补虚药', '平', '辛、甘', '肝、肾、脾', 6, 12, 'g', 0, '补肾益精，养肝明目', '阳痿遗精，尿有余沥，目昏耳鸣');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('萆薢', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('葛根', '解表药', '凉', '甘、辛', '脾、胃、肺', 10, 15, 'g', 0, '解肌退热，生津止渴，透疹', '外感发热，项背强痛，口渴');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('葶苈子', '化痰止咳平喘药', '大寒', '辛、苦', '肺、膀胱', 3, 10, 'g', 0, '泻肺平喘，行水消肿', '痰涎壅肺，喘咳痰多');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('蒲公英', '清热药', '寒', '苦、甘', '肝、胃', 10, 15, 'g', 0, '清热解毒，消肿散结，利湿通淋', '痈肿疔毒，乳痈内痈，热淋涩痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('蒲黄', '止血药', '平', '甘', '肝、心包', 3, 10, 'g', 0, '止血，化瘀，通淋', '吐血，衄血，咯血，崩漏');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('蒺藜', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('蔓荆子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('薄荷', '解表药', '凉', '辛', '肺、肝', 3, 6, 'g', 0, '疏散风热，清利头目，利咽透疹', '风热感冒，头痛目赤，咽喉肿痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('薏苡仁', '利水渗湿药', '凉', '甘、淡', '脾、胃、肺', 10, 30, 'g', 0, '利水渗湿，健脾止泻，除痹排脓', '水肿，脚气，脾虚泄泻');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('藁本', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('藿香', '化湿药', '微温', '辛', '脾、胃、肺', 5, 10, 'g', 0, '芳香化湿，和中止呕', '湿阻中焦，呕吐');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('虎骨', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('蛇床子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('蛤蚧', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('蝉蜕', '解表药', '寒', '甘', '肺、肝', 3, 10, 'g', 0, '疏散风热，利咽开音，透疹', '风热感冒，咽痛音哑，麻疹不透');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('补骨脂', '补虚药', '温', '辛、苦', '肾、脾', 6, 10, 'g', 0, '补肾壮阳，固精缩尿，温脾止泻', '腰膝冷痛，阳痿遗精，遗尿尿频');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('覆盆子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('诃子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('贝母', '化痰止咳平喘药', '微寒', '苦、甘', '肺、心', 3, 10, 'g', 0, '清热化痰，润肺止咳，散结消肿', '虚劳咳嗽，肺热燥咳');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('赤小豆', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('赤小豆皮', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('赤石脂', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('赤芍', '清热药', '微寒', '苦', '肝', 6, 12, 'g', 0, '清热凉血，散瘀止痛', '温毒发斑，目赤肿痛，跌打损伤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('车前子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('辰砂', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('远志', '安神药', '温', '苦、辛', '心、肾、肺', 3, 10, 'g', 0, '安神益智，祛痰开窍', '失眠多梦，健忘惊悸');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('连翘', '清热药', '微寒', '苦', '肺、心、小肠', 6, 15, 'g', 0, '清热解毒，消肿散结，疏散风热', '痈肿疮毒，瘰疬痰核，风热外感');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('通草', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('郁金', '活血化瘀药', '寒', '辛、苦', '肝、心、肺', 3, 10, 'g', 0, '活血止痛，行气解郁，清心凉血', '胸胁刺痛，胸痹心痛，热病神昏');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('酸枣仁', '安神药', '平', '甘、酸', '肝、胆、心', 10, 20, 'g', 0, '养心补肝，宁心安神，敛汗生津', '虚烦不眠，惊悸多梦');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('金箔', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('金银花', '清热药', '寒', '甘', '肺、心、胃', 6, 15, 'g', 0, '清热解毒，疏散风热', '痈肿疔疮，外感风热，热毒血痢');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('钩藤', '平肝息风药', '凉', '甘', '肝、心包', 3, 12, 'g', 0, '清热平肝，息风止痉', '头痛眩晕，惊痫抽搐');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('银箔', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('锁阳', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('防己', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('防风', '解表药', '微温', '辛、甘', '膀胱、肝、脾', 5, 10, 'g', 0, '祛风解表，胜湿止痛，止痉', '外感表证，风疹瘙痒，风湿痹痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('阿胶', '补虚药', '平', '甘', '肺、肝、肾', 3, 9, 'g', 0, '补血滋阴，润燥止血', '血虚萎黄，眩晕心悸，多种出血证');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('附子', '温里药', '大热', '辛', '心、肾、脾', 3, 15, 'g', 1, '回阳救逆，补火助阳，散寒止痛', '亡阳虚脱，肢冷脉微，阳痿宫冷');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('附片', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('陈皮', '理气药', '温', '辛、苦', '脾、肺', 3, 10, 'g', 0, '理气健脾，燥湿化痰', '脘腹胀满，食少吐泻，咳嗽痰多');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('雄黄', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('青竹叶', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('青葙子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('青蒿', '清热药', '寒', '苦、辛', '肝、胆', 6, 12, 'g', 0, '清虚热，除骨蒸，解暑截疟', '温邪伤阴，阴虚发热，疟疾寒热');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('韭菜子', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('首乌', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('香附', '理气药', '平', '辛、微苦、微甘', '肝、脾、三焦', 6, 10, 'g', 0, '疏肝解郁，理气宽中，调经止痛', '肝郁气滞，胸胁胀痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('鱼脑石', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('鸡子黄', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('鸡血藤', '活血化瘀药', '温', '苦、甘', '肝、肾', 10, 30, 'g', 0, '活血补血，调经止痛，舒筋活络', '月经不调，痛经经闭，风湿痹痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('鹿胶', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('鹿茸', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('鹿角', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('鹿角胶', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('鹿角霜', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('麝香', '开窍药', '温', '辛', '心、脾', 0.03, 0.1, 'g', 0, '开窍醒神，活血通经，消肿止痛', '热病神昏，中风痰厥');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('麦冬', '补虚药', '微寒', '甘、微苦', '心、肺、胃', 6, 12, 'g', 0, '养阴润肺，益胃生津，清心除烦', '肺燥干咳，阴虚痨嗽，喉痹咽痛');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('麦芽', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('麦门冬', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('麻仁', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('麻黄', '解表药', '温', '辛、微苦', '肺、膀胱', 2, 10, 'g', 0, '发汗解表，宣肺平喘，利水消肿', '风寒感冒，咳嗽气喘，风水水肿');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('黄柏', '清热药', '寒', '苦', '肾、膀胱', 3, 12, 'g', 0, '清热燥湿，泻火解毒，退虚热', '湿热下注，带下黄稠，阴虚发热');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('黄精', '补虚药', '平', '甘', '脾、肺、肾', 9, 15, 'g', 0, '补气养阴，健脾润肺，益肾', '脾胃气虚，肺虚燥咳，精血不足');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('黄芩', '清热药', '寒', '苦', '肺、胆、脾、胃、大肠、小肠', 3, 10, 'g', 0, '清热燥湿，泻火解毒，止血安胎', '湿温暑湿，肺热咳嗽，热毒疮疡');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('黄芪', '补虚药', '微温', '甘', '脾、肺', 10, 30, 'g', 0, '补气升阳，固表止汗，利水消肿', '气虚乏力，食少便溏，中气下陷');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('黄连', '清热药', '寒', '苦', '心、脾、胃、胆、大肠', 2, 10, 'g', 0, '清热燥湿，泻火解毒', '湿热痞满，呕吐吞酸，泻痢');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('龙胆', '清热药', '寒', '苦', '肝、胆', 3, 6, 'g', 0, '清热燥湿，泻肝胆火', '湿热黄疸，阴肿阴痒，目赤');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('龙骨', '安神药', '平', '甘、涩', '心、肝、肾', 15, 30, 'g', 0, '镇惊安神，平肝潜阳', '心神不宁，心悸失眠');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('龙齿', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('龟板', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications) VALUES
('龟甲', '其他', '平', '', '', 3, 10, 'g', 0, '', '');
