# Matching codes (Flow-Shapefile)

library(here)

require(tidyverse)

require(stringr)

require(raster)

setwd(here())

setwd('data/China_raw/shapefiles_pop_2020/united_nations')

# read 

s <- shapefile('chn_admbnda_adm2_ocha_2020.shp')

d <- s@data

f <- read.csv('location_in_flow.csv')

# match strings

str(d$ADM2_PCODE)

sub( 'CN','', d$ADM2_PCODE)

d$code_aux <- paste0(sub( 'CN0','', d$ADM2_PCODE),'0') 

# So, Beijin is 
#CN0  110100 in shape
#     110000 in flow
# Karamai is Kelamayshi synonym
# 651000 in shape (CN065100)
# 650200 in flow 

# 83 exclusive of shapefile

just_in_d <- setdiff(d$code_aux, f$GB_Code.) #CN011010

setdiff(d$ADM2_EN, f$Name.) 

length(just_in_d)

# 74 exclusive of flow (final df-to-be)

just_in_f <- s4etdiff(f$GB_Code., d$code_aux) # Beijin etc..

length(just_in_f)

head(f)
nrow(f)
length(unique(f$GB_Code.)) #352

head(d)
nrow(d)
length(unique(d$ADM2_EN)) #356

length(unique(d$ADM1_EN)) #34 

length(unique(d$ADM2_ZH)) #361

new <- merge(f, d, by.x=c('GB_Code.'), by.y=c( 'code_aux'), all.x=TRUE)

table(is.na(new$ADM2_EN))

new <- new %>% relocate(ADM2_EN, .before = 'OBJECTID')

# Manual matches with syntax and spatial map (QGIS + Google maps inspection + dictionaries)
# When 2 names were similar (such as Shaoyang and Chaoyeang), decision was made by code first digits similarity (Province call)

#------------ 21/04/2022
# 13h - 14h
new[1,'ADM2_EN'] <- 'Beijing Municipality'
new[2,'ADM2_EN'] <- 'Tianjin Municipality'
new[34,'ADM2_EN'] <- 'Hinggan League' #Xinganmeng # Inner Mongolia
new[35,'ADM2_EN'] <- 'Xilingol League' # Xilinguoleimeng # Inner Mongolia
new[36,'ADM2_EN'] <- 'Alxa League' #Alashanmeng
new[59,'ADM2_EN'] <- 'Yanbian Korean Autonomous Prefecture' #Yanbianchaoxianzuzizhizhou
new[71,'ADM2_EN'] <- 'Daxinganling Prefecture' #Daxinganlingdiqu
new[72,'ADM2_EN'] <- 'Shanghai Municipality' # Shanghaishi
new[107,'ADM2_EN'] <- 'Chizhou'     #Chizhoushi
new[108,'ADM2_EN'] <- 'Xuancheng'   #Xuanchengshi
# 14h - 14h14
new[159,'ADM2_EN'] <- 'Jiyuan'   #Jiyuanshi
new[172,'ADM2_EN'] <- 'Enshi Tujia and Miao Autonomous Prefecture' #Enshitujiazumiaozuzizhizhou
new[173,'ADM2_EN'] <- 'Xiantao'  #Xiantaoshi
new[174,'ADM2_EN'] <- 'Qianjiang'  #Qianjiangshi
new[175,'ADM2_EN'] <- 'Tianmen' #Tianmenshi
new[176,'ADM2_EN'] <- 'Shennongjia Forestry District' #Shennongjialinqu
new[190,'ADM2_EN'] <- 'Xiangxi Tujia and Miao Autonomous Prefecture' #Xiangxitujiazumiaozuzizhizhou
new[209,'ADM2_EN'] <- 'Chaozhou'  #Chaozhoushi
new[210,'ADM2_EN'] <- 'Jieyang' #Jieyangshi
new[211,'ADM2_EN'] <- 'Yunfu'# Yunfushi
# 16h18 - 14h04
new[229,'ADM2_EN'] <- 'Wuzhishan City' # Wuzhishanshi
new[230,'ADM2_EN'] <- 'Qionghai City' #Qionghaishi
new[232,'ADM2_EN'] <- 'Wanning City' # Wanningshi
new[233,'ADM2_EN'] <- 'Dongfang City'  #Dongfangshi
#-------
new[234,'ADM2_EN'] <- 'Ding\'an County' #Dinganxian FLAG ESCAPE APOSTROPHE, CHECK IF IT MERGES
#-------
new[235,'ADM2_EN'] <- 'Tunchang County'# Tunchangxian
new[236,'ADM2_EN'] <- 'Chengmai County'# Chengmaixian
new[237,'ADM2_EN'] <- 'Lingao County' #Lingaoxian
new[238,'ADM2_EN'] <- 'Baisha Li Autonomous County' #Baishalizuzizhixian
# 18h35 - 19-10
new[239,'ADM2_EN'] <- 'Changjiang Li Autonomous County' #Changjianglizuzizhixian
new[240,'ADM2_EN'] <- 'Ledong Li Autonomous County' # Ledonglizuzizhixian
new[241,'ADM2_EN'] <- 'Lingshui Li Autonomous County' #Lingshuilizuzizhixian
new[242,'ADM2_EN'] <- 'Baoting Li and Miao Autonomous County'# Baotinglizumiaozuzizhixian
new[243,'ADM2_EN'] <- 'Qiongzhong Li and Miao Autonomous County' #Qiongzhonglizumiaozuzizhixian
new[244,'ADM2_EN'] <- 'Chongqing Municipality' #Chongqingshi
new[263,'ADM2_EN'] <- 'Ngawa Tibetan and Qiang Autonomous Prefecture' #Abazangzuqiangzuzizhizhou #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Abazangzuqiangzuzizhizhou
new[264,'ADM2_EN'] <- 'GarzÃª Tibetan Autonomous Prefecture' #Ganzizangzuzizhizhou #FLAG SPECIAL CHARACTER Garze!!!
new[265,'ADM2_EN'] <- 'Liangshan Yi Autonomous Prefecture' #Liangshanyizuzizhizhou
new[272,'ADM2_EN'] <- 'Qianxinan Buyi and Miao Autonomous Prefecture' #Qianxinanbuyizumiaozuzizhizhou
# 19h23 - 19h38
new[273,'ADM2_EN'] <- 'Qiandongnan Miao and Dong Autonomous Prefecture' # Qiandongnanmiaozudongzuzizhizhou
new[274,'ADM2_EN'] <- 'Qiannan Buyi and Miao Autonomous Prefecture'  # Qiannanbuyizumiaozuzizhizhou
new[283,'ADM2_EN'] <- 'Chuxiong Yi Autonomous Prefecture' # Chuxiongyizuzizhizhou
new[284,'ADM2_EN'] <- 'Honghe Hani and Yi Autonomous Prefecture'  #Honghehanizuyizuzizhizhou
new[285,'ADM2_EN'] <- 'Wenshan Zhuang and Miao Autonomous Prefecture' #Wenshanzhuangzumiaozuzizhizhou
new[286,'ADM2_EN'] <- 'Xishuangbanna Dai Autonomous Prefecture' # Xishuangbannadaizuzizhizhou
new[287,'ADM2_EN'] <- 'Dali Bai Autonomous Prefecture' # Dalibaizuzizhizhou
new[288,'ADM2_EN'] <- 'Dehong Dai and Jingpo Autonomous Prefecture'  # Dehongdaizujingpozuzizhizhou
new[289,'ADM2_EN'] <- 'Nujiang Lisu Autonomous Prefecture' #Nujianglisuzuzizhizhou
new[290,'ADM2_EN'] <- 'DÃªqÃªn Tibetan Autonomous Prefecture' #Diqingzangzuzizhizhou FLAG SPECIAL CHARACTER Dêqên, é em Shangri-la City
new[297,'ADM2_EN'] <- 'Ngari Prefecture' #Alidiqu #Ngari prefecture in Tibet, Tibetan: Mnga' ris sa khul  #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Alidiqu
# 19h38 - 19-56 #Ngari Prefecture
new[319,'ADM2_EN'] <- 'Linxia Hui Autonomous Prefecture' #Linxiahuizuzizhizhou
new[320,'ADM2_EN'] <- 'Gannan Tibetan Autonomous Prefecture'  #Gannanzangzuzizhizhou
new[323,'ADM2_EN'] <- 'Haibei Tibetan Autonomous Prefecture' #Haibeizangzuzizhizhou
new[324,'ADM2_EN'] <- 'Huangnan Tibetan Autonomous Prefecture' #Huangnanzangzuzizhizhou
new[325,'ADM2_EN'] <- 'Hainan Tibetan Autonomous Prefecture'  #Hainanzangzuzizhizhou
new[326,'ADM2_EN'] <- 'Golog Tibetan Autonomous Prefecture' #Guoluozangzuzizhizhou
new[327,'ADM2_EN'] <- 'Yushu Tibetan Autonomous Prefecture' #Yushuzangzuzizhizhou
new[328,'ADM2_EN'] <- 'Haixi Mongolian Autonomous Prefecture'  #Haiximengguzuzangzuzizhizhou
new[338,'ADM2_EN'] <- 'Changji Hui Autonomous Prefecture'  #Changjihuizuzizhizhou
new[339,'ADM2_EN'] <- 'Bortala Mongol Autonomous Prefecture'  #Boertalamengguzizhizhou
# 19-56 -20:54
new[340,'ADM2_EN'] <- 'Bayingolin Mongolia Autonomous Prefecture'  #Bayinguolengmengguzizhizhou
new[341,'ADM2_EN'] <- 'Aksu Prefecture'  #Akesudiqu
new[342,'ADM2_EN'] <- 'Kizilsu Kirgiz Autonomous Prefecture' #Kezileisukeerkezizizhizhou #https://en.wikipedia.org/wiki/Kizilsu_Kyrgyz_Autonomous_Prefecture
new[343,'ADM2_EN'] <- 'Kashi Prefecture' #Kashidiqu #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Kashidiqu
new[344,'ADM2_EN'] <- 'Hotan Prefecture' #Hetiandiqu #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Hetiandiqu
new[345,'ADM2_EN'] <- 'Ili Kazak Autonomous Prefecture' #Yilihasakezizhizhou #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Yilihasakezizhizhou
new[346,'ADM2_EN'] <- 'TarbaÄatay Prefecture' #Tachengdiqu # FLAG SPECIAL CHARACTER!!! Tǎ chéng dì qū #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Tachengdiqu
new[347,'ADM2_EN'] <- 'Altay Prefecture'  #Aleitaidiqu #Ā lè tài
new[348,'ADM2_EN'] <- 'Shihezi'  #Shihezishi

# End of work in 21/04/2022

# Starting 22/04/2022

#-------------------------------------------------------------------------------------------------------------
# Flags of wrong code match from shape to flow df, so going again by syntax manual curation

# 10h19 - 10h50
new[123,'ADM2_EN'] <- 'Ganzhou' # Ganzhoushi
new[3,'ADM2_EN'] <- 'Shijiazhuang' #Shijiazhuangshi
new[4,'ADM2_EN'] <- 'Tangshan' #Tangshanshi
new[5,'ADM2_EN'] <- 'Qinhuangdao'  #Qinhuangdaoshi
new[7,'ADM2_EN'] <- 'Xingtai'   #Xingtaishi
new[8,'ADM2_EN'] <- 'Baoding' #Baodingshi
new[9,'ADM2_EN'] <- 'Zhangjiakou'  #Zhangjiakoushi
new[10,'ADM2_EN'] <- 'Chengde' #Chengdeshi
new[11,'ADM2_EN'] <- 'Cangzhou'  #Cangzhoushi
new[12,'ADM2_EN'] <- 'Langfang' #Langfangshi
new[13,'ADM2_EN'] <- 'Hengshui' #Hengshuishi
new[14,'ADM2_EN'] <- 'Taiyuan' #Taiyuanshi
new[16,'ADM2_EN'] <- 'Yangquan' #Yangquanshi
new[17,'ADM2_EN'] <- 'Changzhi' #Zhangzhishi , 治市", Changzhi in google maps (got the city in mandarim from https://github.com/trrying/RecycleViewSwipe/blob/master/feifanCityJson.txt)
new[18,'ADM2_EN'] <- 'Jincheng' #Jinchengshi
new[19,'ADM2_EN'] <- 'Shuozhou' #Shuozhoushi
new[20,'ADM2_EN'] <- 'Jinzhong' #Jinzhongshi
new[21,'ADM2_EN'] <- 'Yuncheng' #Yunchengshi
new[23,'ADM2_EN'] <- 'Linfen' #Linfenshi
new[24,'ADM2_EN'] <- 'LÃ¼liang' #Lvliangshi , Lüliang, 吕梁市 #FLAG SPECIAL CHARACTER
# 10h54 - 11h36
new[25,'ADM2_EN'] <- 'Hohhot' #Huhehaoteshi #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Huhehaoteshi
new[27,'ADM2_EN'] <- 'Wuhai'  #Wuhaishi
new[29,'ADM2_EN'] <- 'Tongliao' # Tongliaoshi
new[30,'ADM2_EN'] <- 'Ordos' #Eerduosishi #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Eerduosishi
new[32,'ADM2_EN'] <- 'Bayannur' #Bayannaoershi #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Bayannaoershi
new[33,'ADM2_EN'] <- 'Ulanqab' #Wulanchabushi #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Wulanchabushi
new[37,'ADM2_EN'] <- 'Shenyang' #Shenyangshi #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Shenyangshi
new[38,'ADM2_EN'] <- 'Dalian' #Dalianshi
new[39,'ADM2_EN'] <- 'Anshan'  #Anshanshi
new[40,'ADM2_EN'] <- 'Fushun' #Fushunshi
new[41,'ADM2_EN'] <- 'Benxi' #Benxishi
new[42,'ADM2_EN'] <- 'Dandong'  #Dandongshi
new[43,'ADM2_EN'] <- 'Jinzhou' #Jinzhoushi
new[44,'ADM2_EN'] <- 'Yingkou' #Yingkoushi
new[45,'ADM2_EN'] <- 'Fuxin' #Fuxinshi
new[48,'ADM2_EN'] <- 'Tieling' #Tielingshi
#----
new[49,'ADM2_EN'] <- 'Chaoyang' #Zhaoyangshi #"pinyin": "zhaoyangshi" #https://github.com/migijs/migi-city/blob/master/src/city.json
#https://www.its203.com/article/Long861774/108318312 # Decision took based on code similarity
new[50,'ADM2_EN'] <- 'Huludao'  #Huludaoshi 
new[51,'ADM2_EN'] <- 'Changchun'  #Changchunshi
new[52,'ADM2_EN'] <- 'Jilin' #Jilinshi
new[53,'ADM2_EN'] <- 'Siping'  #Sipingshi
# 36% names curated roughly 54+74 / 352
# 13h15-13h46
new[54,'ADM2_EN'] <- 'Liaoyuan' #Liaoyuanshi
new[55,'ADM2_EN'] <- 'Tonghua' #Tonghuashi
new[56,'ADM2_EN'] <- 'Baishan' #Baishanshi
new[58,'ADM2_EN'] <- 'Baicheng'  #Baichengshi
new[60,'ADM2_EN'] <- 'Harbin' #Haerbinshi  #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Haerbinshi
new[61,'ADM2_EN'] <- 'Qiqihar' #Qiqihaershi
new[62,'ADM2_EN'] <- 'Jixi' #Jixishi
new[64,'ADM2_EN'] <- 'Shuangyashan'  #Shuangyashanshi
new[65,'ADM2_EN'] <- 'Daqing'  #Daqingshi
new[66,'ADM2_EN'] <- 'Jiamusi'  #Jiamusishi
new[67,'ADM2_EN'] <- 'Qitaihe'  #Qitaiheshi
new[68,'ADM2_EN'] <- 'Mudanjiang'  #Mudanjiangshi
new[69,'ADM2_EN'] <- 'Heihe' #Heiheshi
new[73,'ADM2_EN'] <- 'Nanjing' #Nanjingshi
new[74,'ADM2_EN'] <- 'Wuxi' #Wuxishi
new[75,'ADM2_EN'] <- 'Xuzhou'  #Xuzhoushi
new[76,'ADM2_EN'] <- 'Changzhou'  #Changzhoushi
new[77,'ADM2_EN'] <- 'Nantong' #Nantongshi
new[78,'ADM2_EN'] <- 'Lianyungang' #Lianyungangshi
new[79,'ADM2_EN'] <- 'Huai\'an'  #Huaianshi #FLAG CHARACTER ESCAPED 
new[80,'ADM2_EN'] <- 'Yancheng'  #Yanchengshi
new[81,'ADM2_EN'] <- 'Yangzhou'   #Yangzhoushi
new[82,'ADM2_EN'] <- 'Zhenjiang' #Zhenjiangshi
new[83,'ADM2_EN'] <- 'Suqian' #Suqianshi
new[85,'ADM2_EN'] <- 'Ningbo'  #Ningboshi
new[86,'ADM2_EN'] <- 'Wenzhou'  # Wenzhoushi
new[87,'ADM2_EN'] <- 'Jiaxing' #Jiaxingshi
new[88,'ADM2_EN'] <- 'Huzhou' #Huzhoushi
new[89,'ADM2_EN'] <- 'Shaoxing' #Shaoxingshi
new[90,'ADM2_EN'] <- 'Jinhua'  #Jinhuashi
new[91,'ADM2_EN'] <- 'Quzhou'  #Quzhoushi
new[92,'ADM2_EN'] <- 'Zhoushan'  #Zhoushanshi
new[93,'ADM2_EN'] <- 'Lishui' #Lishuishi
new[94,'ADM2_EN'] <- 'Hefei' #Hefeishi
new[95,'ADM2_EN'] <- 'Wuhu'  #Wuhushi
new[96,'ADM2_EN'] <- 'Bengbu'  #Bengbushi
new[97,'ADM2_EN'] <- 'Huainan'   #Huainanshi
new[98,'ADM2_EN'] <- 'Ma\'anshan' #Maanshanshi #FLAG CHARACTER ESCAPE
new[99,'ADM2_EN'] <- 'Huaibei'  #Huaibeishi
new[100,'ADM2_EN'] <- 'Tongling' #Tonglingshi
# 14h - 14h18
new[101,'ADM2_EN'] <- 'Anqing'  #Anqingshi
new[103,'ADM2_EN'] <- 'Chuzhou'   #Chuzhoushi
new[104,'ADM2_EN'] <- 'Fuyang' #Fuyangshi
new[105,'ADM2_EN'] <- 'Lu\'an'  #Luanshi #FLAG CHARACTER ESCAPE
new[106,'ADM2_EN'] <- 'Bozhou'  #Bozhoushi
new[109,'ADM2_EN'] <- 'Xiamen' #Xiamenshi
new[110,'ADM2_EN'] <- 'Putian' #Putianshi
new[111,'ADM2_EN'] <- 'Sanming' #Sanmingshi
new[112,'ADM2_EN'] <- 'Quanzhou' #Quanzhoushi
new[113,'ADM2_EN'] <- 'Zhangzhou' #Zhangzhoushi
new[114,'ADM2_EN'] <- 'Nanping' #Nanpingshi
new[115,'ADM2_EN'] <- 'Longyan' #Longyanshi
new[116,'ADM2_EN'] <- 'Ningde' #Ningdeshi
new[117,'ADM2_EN'] <- 'Nanchang' #Nanchangshi 
new[118,'ADM2_EN'] <- 'Jingdezhen'  #Jingdezhenshi
new[119,'ADM2_EN'] <- 'Pingxiang'  #Pingxiangshi
new[120,'ADM2_EN'] <- 'Jiujiang'  #Jiujiangshi
new[121,'ADM2_EN'] <- 'Xinyu'  #Xinyushi
new[122,'ADM2_EN'] <- 'Yingtan'  #Yingtanshi
new[124,'ADM2_EN'] <- 'Ji\'an'  #Jianshi #FLAG CHARACTER ESCAPE
new[125,'ADM2_EN'] <- 'Shangrao'  #Shangraoshi
new[126,'ADM2_EN'] <- 'Jinan' #Jinanshi
new[127,'ADM2_EN'] <- 'Qingdao'  #Qingdaoshi
new[128,'ADM2_EN'] <- 'Zibo' #Ziboshi
new[129,'ADM2_EN'] <- 'Zaozhuang'  #Zaozhuangshi
new[130,'ADM2_EN'] <- 'Dongying'  #Dongyingshi
# 14h35 - 14h48
new[131,'ADM2_EN'] <- 'Yantai'  #Yantaishi
new[132,'ADM2_EN'] <- 'Weifang' #Weifangshi
new[133,'ADM2_EN'] <- 'Jining' #Jiningshi
new[134,'ADM2_EN'] <- 'Tai\'an'  #Taianshi # FLAG CHARACTER ESCAPE
new[135,'ADM2_EN'] <- 'Weihai' #Weihaishi
new[137,'ADM2_EN'] <- 'Linyi' #Linyishi
new[138,'ADM2_EN'] <- 'Dezhou' #Dezhoushi
new[139,'ADM2_EN'] <- 'Liaocheng'  #Liaochengshi
new[140,'ADM2_EN'] <- 'Binzhou'  #Binzhoushi
new[141,'ADM2_EN'] <- 'Heze'   #Hezeshi
new[142,'ADM2_EN'] <- 'Zhengzhou'  #Zhengzhoushi
new[143,'ADM2_EN'] <- 'Kaifeng' #Kaifengshi
new[144,'ADM2_EN'] <- 'Luoyang' #Luoyangshi
new[145,'ADM2_EN'] <- 'Pingdingshan' #Pingdingshanshi
new[146,'ADM2_EN'] <- 'Anyang' #Anyangshi
new[147,'ADM2_EN'] <- 'Hebi' #Hebishi
new[148,'ADM2_EN'] <- 'Xinxiang'  #Xinxiangshi
new[149,'ADM2_EN'] <- 'Jiaozuo' #Jiaozuoshi
new[150,'ADM2_EN'] <- 'Puyang' #Puyangshi
# 14h58 - 15h22
new[151,'ADM2_EN'] <- 'Xuchang'  #Xuchangshi
new[153,'ADM2_EN'] <- 'Sanmenxia'  #Sanmenxiashi
new[154,'ADM2_EN'] <- 'Nanyang'  #Nanyangshi
new[155,'ADM2_EN'] <- 'Shangqiu'     #Shangqiushi
new[156,'ADM2_EN'] <- 'Xinyang'  #Xinyangshi
new[157,'ADM2_EN'] <- 'Zhoukou' #Zhoukoushi
new[158,'ADM2_EN'] <- 'Zhumadian' #Zhumadianshi
new[160,'ADM2_EN'] <- 'Wuhan' #Wuhanshi -----------------------------------------------------
new[161,'ADM2_EN'] <- 'Huangshi'  #Huangshishi
new[162,'ADM2_EN'] <- 'Shiyan'  #Shiyanshi
new[163,'ADM2_EN'] <- 'Yichang' #Yichangshi
new[164,'ADM2_EN'] <- 'Xiangyang' #Xiangyangshi
new[165,'ADM2_EN'] <- 'Ezhou'  #Ezhoushi
new[166,'ADM2_EN'] <- 'Jingmen' #Jingmenshi
new[167,'ADM2_EN'] <- 'Xiaogan' #Xiaoganshi
new[168,'ADM2_EN'] <- 'Jingzhou' #Jingzhoushi
new[169,'ADM2_EN'] <- 'Huanggang' #Huanggangshi
new[170,'ADM2_EN'] <- 'Xianning'  #Xianningshi
new[171,'ADM2_EN'] <- 'Suizhou'  #Suizhoushi
# 16h01 - 16h13
new[177,'ADM2_EN'] <- 'Changsha'   # Changshashi
new[178,'ADM2_EN'] <- 'Zhuzhou' #Zhuzhoushi
new[179,'ADM2_EN'] <- 'Xiangtan' #Xiangtanshi
new[181,'ADM2_EN'] <- 'Shaoyang'  #Shaoyangshi
new[182,'ADM2_EN'] <- 'Yueyang'  #Yueyangshi
new[183,'ADM2_EN'] <- 'Changde'   #Changdeshi
new[184,'ADM2_EN'] <- 'Zhangjiajie' #Zhangjiajieshi
new[185,'ADM2_EN'] <- 'Yiyang' #Yiyangshi
new[186,'ADM2_EN'] <- 'Chenzhou'  #Chenzhoushi
new[188,'ADM2_EN'] <- 'Huaihua' #Huaihuashi
new[189,'ADM2_EN'] <- 'Loudi' #Loudishi
new[191,'ADM2_EN'] <- 'Guangzhou' #Guangzhoushi
new[192,'ADM2_EN'] <- 'Shaoguan' #Shaoguanshi
new[193,'ADM2_EN'] <- 'Shenzhen'  #Shenzhenshi
new[194,'ADM2_EN'] <- 'Zhuhai' #Zhuhaishi
new[195,'ADM2_EN'] <- 'Shantou' #Shantoushi
new[196,'ADM2_EN'] <- 'Foshan'  #Foshanshi
new[198,'ADM2_EN'] <- 'Zhanjiang' #Zhanjiangshi
new[200,'ADM2_EN'] <- 'Zhaoqing' #Zhaoqingshi 

#------------ End of work 22/04/2022

# work 26/04/2022
# 12h55 - 13h14
new[201,'ADM2_EN'] <- 'Huizhou'  #Huizhoushi 
new[202,'ADM2_EN'] <- 'Meizhou' # Meizhoushi
new[203,'ADM2_EN'] <- 'Shanwei' #Shanweishi
new[204,'ADM2_EN'] <- 'Heyuan'  #Heyuanshi
new[205,'ADM2_EN'] <- 'Yangjiang' #Yangjiangshi
new[206,'ADM2_EN'] <- 'Qingyuan'  #Qingyuanshi
new[207,'ADM2_EN'] <- 'Dongguan'  #Dongguanshi
new[208,'ADM2_EN'] <- 'Zhongshan'  #Zhongshanshi
new[209,'ADM2_EN'] <- 'Chaozhou' #Chaozhoushi
new[210,'ADM2_EN'] <- 'Jieyang'  #Jieyangshi
new[211,'ADM2_EN'] <- 'Yunfu'  #Yunfushi
new[212,'ADM2_EN'] <- 'NanNing'  #Nanningshi
new[213,'ADM2_EN'] <- 'Liuzhou'  #Liuzhoushi
new[214,'ADM2_EN'] <- 'Guilin'   #Guilinshi
new[215,'ADM2_EN'] <- 'Wuzhou' #Wuzhoushi
new[216,'ADM2_EN'] <- 'Beihai'  #Beihaishi
new[217,'ADM2_EN'] <- 'Fangchenggang' #Fangchenggangshi
new[218,'ADM2_EN'] <- 'Qinzhou'  #Qinzhoushi
new[219,'ADM2_EN'] <- 'Guigang' #Guigangshi
new[220,'ADM2_EN'] <- 'Baise'  #Baiseshi
new[221,'ADM2_EN'] <- 'Hezhou' #Hezhoushi
new[222,'ADM2_EN'] <- 'Hechi' #Hechishi
new[223,'ADM2_EN'] <- 'Laibin' #Laibinshi
new[224,'ADM2_EN'] <- 'Chongzuo' #Chongzuoshi
new[225,'ADM2_EN'] <- 'Haikou' #Haikoushi
new[226,'ADM2_EN'] <- 'Sanya'  #Sanyashi
new[227,'ADM2_EN'] <- 'Sansha' #Sanshashi
new[228,'ADM2_EN'] <- 'Danzhou' #Danzhoushi
# 13h52 - 14h47
new[245,'ADM2_EN'] <- 'Chengdu'  #Chengdushi
new[246,'ADM2_EN'] <- 'Zigong' #Zigongshi
new[247,'ADM2_EN'] <- 'Panzhihua'  #Panzhihuashi
new[248,'ADM2_EN'] <- 'Luzhou' #Luzhoushi
new[249,'ADM2_EN'] <- 'Deyang'  #Deyangshi
new[250,'ADM2_EN'] <- 'Mianyang' #Mianyangshi
new[251,'ADM2_EN'] <- 'Guangyuan'  #Guangyuanshi
new[252,'ADM2_EN'] <- 'Suining'   #Suiningshi
new[253,'ADM2_EN'] <- 'Neijiang' #Neijiangshi
new[254,'ADM2_EN'] <- 'Leshan'  #Leshanshi
new[256,'ADM2_EN'] <- 'Meishan'   #Meishanshi
new[257,'ADM2_EN'] <- 'Yibin' #Yibinshi
new[258,'ADM2_EN'] <- 'Guang\'an'  #Guanganshi #FLAG CHARACTER ESCAPED ---------------------
new[259,'ADM2_EN'] <- 'Dazhou' #Dazhoushi
new[261,'ADM2_EN'] <- 'Bazhong'  #Bazhongshi
new[262,'ADM2_EN'] <- 'Ziyang' #Ziyangshi
new[266,'ADM2_EN'] <- 'Guiyang' #Guiyangshi
new[267,'ADM2_EN'] <- 'Liupanshui'  #Liupanshuishi
new[268,'ADM2_EN'] <- 'Zunyi' #Zunyishi
new[269,'ADM2_EN'] <- 'Anshun'  #Anshunshi
new[270,'ADM2_EN'] <- 'Bijie'  #Bijieshi
new[271,'ADM2_EN'] <- 'Tongren'  #Tongrenshi
new[275,'ADM2_EN'] <- 'Kunming'  #Kunmingshi
new[276,'ADM2_EN'] <- 'Qujing'  #Qujingshi
new[277,'ADM2_EN'] <- 'Yuxi' #Yuxishi
new[278,'ADM2_EN'] <- 'Baoshan'  #Baoshanshi
new[279,'ADM2_EN'] <- 'Zhaotong'  #Zhaotongshi
new[280,'ADM2_EN'] <- 'Lijiang'   #Lijiangshi
new[281,'ADM2_EN'] <- 'Pu\'er'  #Puershi # FLAG CHARACTER ESCAPED -----------------------
new[282,'ADM2_EN'] <- 'Lincang'  #Lincangshi
new[294,'ADM2_EN'] <- 'Nyingchi'  #Linzhishi # approximation makes sense https://www.google.com/maps/dir/Linzhishi+Youth+League+Committee,+%E8%A5%BF%E5%8C%97%E6%96%B9%E5%90%9170%E7%B1%B3+26,+Bayi+District,+Nyingchi,+Tibet,+China,+860000/Nyingchi,+Tibet,+China/@29.6502881,94.3609463,17z/data=!3m1!4b1!4m14!4m13!1m5!1m1!1s0x376ba0e66503ee69:0x95d06db2332a5803!2m2!1d94.36472!2d29.65275!1m5!1m1!1s0x3715175cdc3cd7bb:0x3881bafe168cc1f8!2m2!1d94.36155!2d29.6489499!3e0
new[292,'ADM2_EN'] <- 'XigazÃª'  #Rikazeshi # # FAG SPECIAL CHARACTERS ---- Xigazê, Shigatse, Tibet, China #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Rikazeshi
new[293,'ADM2_EN'] <- 'Qamdo'  #Changdoushi #HARDEST ONE! #https://www.mindat.org/feature-1280280.html  #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Chengdu
new[295,'ADM2_EN'] <- 'Lhoka' #Shannanshi, Lhoka, Tibet  https://dbpedia.org/page/Shannan,_Tibet, We assume this is the right match, as the other Shannanshi is a sub-level of Zhengzhou
new[296,'ADM2_EN'] <- 'Nagqu Prefecture'  #Naqushi #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Naqushi
new[298,'ADM2_EN'] <- 'Xi\'an' #Xianshi # GLAG CHARACTER ESCAPED #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Xi%27an
new[299,'ADM2_EN'] <- 'Tongchuan' #Tongchuanshi
new[300,'ADM2_EN'] <- 'Baoji'  #Baojishi
# 15h - 15h24
new[301,'ADM2_EN'] <- 'Xianyang'   #Xianyangshi
new[302,'ADM2_EN'] <- 'Weinan' #Weinanshi
new[303,'ADM2_EN'] <- 'Yan\'an' #Yananshi #FLAG CHARACTER ESCAPED ----------------------
new[304,'ADM2_EN'] <- 'Hanzhong'  #Hanzhongshi
new[305,'ADM2_EN'] <- 'Ankang'   #Ankangshi
new[306,'ADM2_EN'] <- 'Shangluo'   #Shangluoshi
new[307,'ADM2_EN'] <- 'Lanzhou'  #Lanzhoushi
new[308,'ADM2_EN'] <- 'Jiayuguan'  #Jiayuguanshi
new[309,'ADM2_EN'] <- 'Jinchang'  #Jinchangshi
new[310,'ADM2_EN'] <- 'Baiyin' #Baiyinshi
new[311,'ADM2_EN'] <- 'Tianshui'  #Tianshuishi
new[312,'ADM2_EN'] <- 'Wuwei'  #Wuweishi
new[313,'ADM2_EN'] <- 'Zhangye'  #Zhangyeshi
new[314,'ADM2_EN'] <- 'Pingliang'  #Pingliangshi
new[315,'ADM2_EN'] <- 'Jiuquan'  #Jiuquanshi
new[316,'ADM2_EN'] <- 'Qingyang'  #Qingyangshi
new[317,'ADM2_EN'] <- 'Dingxi'  #Dingxishi
new[318,'ADM2_EN'] <- 'Longnan'  #Longnanshi
new[321,'ADM2_EN'] <- 'Xining'  #Xiningshi
new[322,'ADM2_EN'] <- 'Haidong'  #Haidongshi
new[329,'ADM2_EN'] <- 'Yinchuan' #Yinchuanshi
new[330,'ADM2_EN'] <- 'Shizuishan' #Shizuishanshi
new[331,'ADM2_EN'] <- 'Wuzhong'  #Wuzhongshi
new[332,'ADM2_EN'] <- 'Guyuan'   #Guyuanshi
new[334,'ADM2_EN'] <- 'ÃœrÃ¼mqi'   #Wulumuqishi #Urumqi #Xinjiang Uygur Autonomous Region # https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Wulumuqishi
new[335,'ADM2_EN'] <- 'Karamay' #Kelamayishi #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Kelamayishi
new[336,'ADM2_EN'] <- 'Turpan' #Tulufanshi #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Tulufanshi
new[337,'ADM2_EN'] <- 'Hami' #Hamishi



#------------ End of curation 26/04/2022

# FLAGS
# Flag curation  (maybe mapping the shapefile to match mobility data, or merge flow data)
# 1) Alaershi
new[349,'ADM2_EN'] <- 'Aksu Prefecture'  #Alaershi # West China #Ā lā ěr shì is a subprefecture of Aksu # FLAG, here the final decision was on Province match  (Xinjiang) after character match https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Alaershi
# 2) Tumushukeshi is probably not in the shapefile for real because it fals in Kashi Prefecture area! Check with Reju
new[350,'ADM2_EN'] <- 'Aksu Prefecture' # Tumushukeshi #Tumxuk shehiri (Tumshuq city, Tumxuk) or Túmùshūkè subprefecture level city in west Xinjiang
# 3) Tiemenguanshi
new[352,'ADM2_EN'] <- 'Bayingolin Mongolia Autonomous Prefecture' #Tiemenguanshi Tiemenguan City falls within the Bayingolin Mongolia Autonomous Prefecture territory
# 4) TAHE Da Hinggan Ling is 2 min from Tahe County, so same polygon, 2 flow information
new[152,'ADM2_EN'] <- 'Daxinganling Prefecture'  #Taheshi  # Tahe county #https://chinese.yabla.com/chinese-english-pinyin-dictionary.php?define=Tahe
#https://www.google.com/maps/place/Tahe+County,+Da+Hinggan+Ling,+Heilongjiang,+China/@52.7477738,123.4603138,8z/data=!3m1!4b1!4m5!3m4!1s0x5e831e0c1af53bf3:0xaf23a138133cd1ba!8m2!3d52.3343199!4d124.71003
# No Tahe in shapefile, it is a sublevel of Daxinganling Prefecture polygon
# 5) Wujiaqu
new[351,'ADM2_EN'] <- 'ÃœrÃ¼mqi' #Wujiaqushi #Wǔ jiā qú shì Wujyachü shehiri (Wujiaqu city) or Wǔjiāqú subprefecture level city in
# Ili Kazakh autonomous prefecture in north Xinjiang
#Wujiaqushi matches the location of the Urumqui city (special characters)
# Spatial proximity of Wujiaqu city and Urumqi https://www.google.com/maps/place/Wujiaqu,+Xinjiang,+China/@43.961497,87.3462949,10z/data=!4m5!3m4!1s0x38062766ef06dd5f:0x88b9ed4d96ee660e!8m2!3d44.1679899!4d87.54017
#Wujyachü shehiri (Wujiaqu city) or Wǔjiāqú subprefecture level city in Ili Kazakh autonomous prefecture in north Xinjiang
# Ili Kazak Autonomous Prefecture is already taken by Yilihasakezizhizhou
# 6) Wenchangshi
new[231,'ADM2_EN'] <- 'Qionghai City' # Wenchangshi ############################IN HAINAN island, close to  It shoud be approximated to Qionghai City (taken) or Danzhou (not taken)

# Merge with shapefile
newsub <- new[,c('GB_Code.', 'Name.', 'ADM2_EN')]
table(newsub$ADM2_EN)
which(is.na(newsub$ADM2_EN))
newsub[which(is.na(newsub$ADM2_EN)) ,]

table(table(newsub$ADM2_EN) > 1 )

snew <- s

table(table(newsub$ADM2_EN) > 1)

# Check remaining duplicates ---------------------------------------------------------------------------------

new %>% 
  group_by(ADM2_EN) %>% 
  filter(n()>1)


newsub %>% 
  group_by(ADM2_EN) %>% 
  filter(n()>1)

length(unique(newsub %>% 
                group_by(ADM2_EN) %>% 
                filter(n()>1)))

 flags <- unique(newsub %>% 
         group_by(ADM2_EN) %>% 
         filter(n()>1)) 


 # Duplicate ADM2_EN in shape

snew@data %>% 
  group_by(ADM2_EN) %>% 
  filter(n()>1)

# Flags for different reasons (oduble check needed, sub-level polygon needed, not included in shapefile, special regions)
setdiff(newsub$ADM2_EN, s$ADM2_EN)

# Unique from shapefile  - Delete? look one by one and discuss with Reju (no mobility, no space)
setdiff(s$ADM2_EN, newsub$ADM2_EN)


# Luohe is close to Zhoukou 
only_in_shape <- s[s$ADM2_EN %in% setdiff(s$ADM2_EN, newsub$ADM2_EN), ]

plot(s, main='Only in shapefile')
plot(s[s$ADM2_EN %in% setdiff(s$ADM2_EN, newsub$ADM2_EN), ], col='red', add=TRUE)
text(s[s$ADM2_EN %in% setdiff(s$ADM2_EN, newsub$ADM2_EN), ],  s@data[s$ADM2_EN %in% setdiff(s$ADM2_EN, newsub$ADM2_EN),'ADM2_EN' ],
     cex=0.75, pos=3, col="black") 



# newsub merge to complete cases

new_complete <- merge(newsub, s@data, by.x=c('ADM2_EN'), by.y=c('ADM2_EN'), all.x=TRUE, all.y=FALSE)
nrow(newsub)
nrow(new_complete)

head(new_complete)

new_complete_sub <- new_complete[,c('GB_Code.', 'Name.', 'ADM2_EN', 'ADM2_PCODE')]

only_in_shape <- setdiff(s$ADM2_EN, newsub$ADM2_EN)

flags$ADM2_EN

new_complete_sub$flag_type <- ('none')

new_complete_sub[new_complete_sub$ADM2_EN %in% flags$ADM2_EN,'flag_type' ] <- 'As there is only one polygon for multiple GB_Codes you should MERGFE FLOW '
  
nrow(newsub) #352
nrow(s) # 361

# Removing duplicates to match shapefile

new_to_merge <- new_complete_sub[,c('GB_Code.', 'Name.', 'ADM2_EN', 'flag_type')]

new_to_export <- new_complete_sub[,c('GB_Code.', 'Name.', 'ADM2_EN', 'ADM2_PCODE','flag_type')]

dfmerged <- merge(s@data, distinct(new_to_merge, ADM2_EN, .keep_all= TRUE), by.x=c('ADM2_EN'), by.y=c('ADM2_EN'), all.x=TRUE, all.y=FALSE)

dfmerged[dfmerged$ADM2_EN %in% only_in_shape,'flag_type' ] <- 'A polygon exists but is missing flow data'

nrow(dfmerged)

head(dfmerged)

snew@data <-  dfmerged

nrow(snew)

nrow(s)

nrow(snew)

nrow(newsub)

# Export final files

setwd(here())

setwd('data/China_raw/')

dir.create('spatial_match')

setwd('spatial_match')

write.csv(new_to_export, 'location_in_flow_spatial_match_ADM2_PCODE.csv')

shapefile(snew, 'spatial_match.shp', overwrite=TRUE)

#Warning 1: One or several characters couldn't be converted correctly from UTF-8 to ISO-8859-1.  This warning will not be emitted anymore.

# Write metadata and short methods

#----------------------------------------------------------------------------------------------------
