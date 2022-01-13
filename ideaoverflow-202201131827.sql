-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: ideaoverflow
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.22-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `follower`
--

DROP TABLE IF EXISTS `follower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `follower` (
  `followee_id` int(11) NOT NULL,
  `follower_id` int(11) NOT NULL,
  PRIMARY KEY (`followee_id`,`follower_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follower`
--

LOCK TABLES `follower` WRITE;
/*!40000 ALTER TABLE `follower` DISABLE KEYS */;
INSERT INTO `follower` VALUES (1,3),(2,1),(2,3),(3,1),(3,2);
/*!40000 ALTER TABLE `follower` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_owner_user_id` int(11) NOT NULL,
  `creation_date` date NOT NULL DEFAULT curdate(),
  `title` varchar(100) NOT NULL,
  `body` varchar(10000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,1,'2022-01-11','FalafeldÃ¶ner','<p>Lecker!!!</p><p><br></p><iframe class=\"ql-video\" frameborder=\"0\" allowfullscreen=\"true\" src=\"https://www.youtube.com/embed/1bZCwrevP-M?showinfo=0\"></iframe><p><br></p><p><a href=\"https://www.wir-essen-gesund.de/falafel-doener/\" rel=\"noopener noreferrer\" target=\"_blank\">https://www.wir-essen-gesund.de/falafel-doener/</a></p><p><br></p>'),(2,1,'2022-01-12','Loool','<h2>asdf</h2><p><br></p><p>fifsadf</p>'),(3,3,'2022-01-12','Hi Herbert','<iframe class=\"ql-video\" frameborder=\"0\" allowfullscreen=\"true\" src=\"https://www.youtube.com/embed/TwKEif_ASmA?showinfo=0\"></iframe><p><br></p>');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_has_tag`
--

DROP TABLE IF EXISTS `post_has_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_has_tag` (
  `fk_post_id` int(11) NOT NULL,
  `fk_tag_id` int(11) NOT NULL,
  PRIMARY KEY (`fk_post_id`,`fk_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_has_tag`
--

LOCK TABLES `post_has_tag` WRITE;
/*!40000 ALTER TABLE `post_has_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_has_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `verificationcode` varchar(100) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `website` varchar(100) NOT NULL,
  `github` varchar(100) NOT NULL,
  `twitter` varchar(100) NOT NULL,
  `instagram` varchar(100) NOT NULL,
  `private` tinyint(1) NOT NULL,
  `country` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `dribbble` varchar(100) NOT NULL,
  `linkedin` varchar(100) NOT NULL,
  `profileimage` blob NOT NULL,
  `creationdate` date NOT NULL DEFAULT curdate(),
  `bio` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'hiebeler.daniel@gmail.com','daniebeler','$2b$04$H.qrdjSQ0pP0EBhd2aJsuOmr0Ef0uQ6E2qU0ZlpaF2tNVyKzVPiSK','',1,'Daniel','Hiebeler','https://daniebeler.com','daniebeler','daniebeler','daniebeler',0,'Belize','Bie','daniebeler','daniebeler','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0 \0\0\0 \0\0\0‹Ïg-\0\0 \0IDATxœ­}	´eEuöW÷Ý÷º_4Ý\rM3ˆ325‚ N8Dg£‘ú\'&j¢fiâŠcgÿDã<üŠ\'PQQTD©Fèfè¦›×Ýoºõ¯¯î©s÷Ýwï:ç‘ÔZïÝ{Ï©a×Þ_í½k6l¸\rÀò#B`àwò3ÆÉqu<ýNçÇß½^/}êô:nþìt:Cy1}~žC~&óã÷±±±¡4­’.ë¹üžó’ôKÚòg._óA—mñ(×7¿Û¹s\'öÚk/<ïyÏÃ-·Ü‚¯ýëOñ¬´’?š¿º.²Þ:¾N#CŽË´¹L]G]¶U~ŒqGÀzÍ<‹Q^æÖsýYŠkýÖ\0°S¢Ã£G¦—€²#ËµxSzgå¥K¡I°zßr©¾mŠäƒU\'«Ž¤{~~¾¦_–éØ£)Æ¸¼CZ•ðÐÁ®þniRœ6ß-fY•†\0üó„¤Ó”êQ¢BÐ=:„mê¬i”yYõó\0«ãyyéø¹1[ÊÅüŽN©•4µî1žI-	¼4³ÚÒ™Mu©¯äßÒÜ•ÊlC[‰º|¯!”@ª…Ü$Ã’»åYF[YÀ‘aÇíÜ”¹÷[û%Zï=?KúnP¶|M¨ÙdfsV9uJ`hãiàY\Zª‰¯ú»U¶`·´ZSý¤ë‘ÄBü4«IgåQ2Q^y²%ÿLúZMñBåkMËòO-­f™DM»~—ó±üR‹^}ô÷¦÷µFP¼ÓÏšè”q:^fm\n/e\\J£µTÛÊÏÒ’ò¯mÐ¦Öã‡\ZÙGƒ`¬¼¤–µÞ1ÌÍÍôô›\ZF‰‹ù;k|-Y†î…[¦ßÓ¬2M§I…zBöÞ{ÌÖLÒÀÓ•ÐŽq©LýÜÓJVðÞ/Ä·)1¾D«ÔtV|\nyjj*}.Z´Ýn×t)t™÷Çï»?ùéº{y[yå2Zù€¥ÖÜTY8-Dú`Vë‰U·½ŠZ.ÑhÅµh‡­Y´?é•-Íl‰^ŽanÛ¶\r+W®ÄÉ\'Ÿœ>ï½÷^LOO€p¡ÖÃ¢GþÖõÔã¨:NÉÖåhÓºR\"ZËñoÃ M¬Œ’–jj¥–\ZU‡Ä£¹­ uc)¥“cgüžÿ¶nÝš´Þgœ#<W]u.¾øâô,°—\Z‡´öWKtuŒ\0çBù3TÏY½?~žLß&Ç@\rQÒ°Mš¦ä_Z>ŠåÏµÕºMu,ÅÑ4|4·§Ÿ~:?üpüêW¿Â¹çž›Ìñ’%KL³í5Î…4`M›tÚ4~ùÙäæÐ-1ÃžÃ[ÊÇSÇMñ´ÿ`µ8íóiFèï2´Õ¶3Ûj\0Èphv\'\'\'qÚi§%Í÷óŸÿçw^êˆÐsBóÏª£‚6Ö¢Ý\nA\rs5ñ×Ëg¨Ü†‘ºÂmÒéPêøxþŸE‹õ¼i®ÙJŸßéNÁBC[m“gó–M]6»gžy&Ž:ê(\\yå•8çœs0;;‹=öØcˆ>=ÀÞÖïµ\Zœè F$ØôˆA“ì=—¨ã%öÌ¨%¸R‹¶òlãky>”–nyÒ§jÛ{Ó~O[¿Fk™R(iâlv3ø=ôÐ>š]‚Žàkh‹^+ž\'#Ë—ÔÁ’—¯çÂÔ\rÉã™¥E¬\n¢A£yyÃ¶$®É•š£Ö²‘Ë·VÂèò<·ãjH?Í.;ôùŽ8âˆÔáøÊW¾‚™™×ìêÆ¬ÇåÚ(…RGËòá¢Ó#Ö|jSv€M¦Ëó9þ·ƒ6	º¢z(Ãêt”´aIƒ5ù|ž&ƒ‡Ý=÷Üƒ‰‰	œuÖYÉì^qÅCà‹ª“¡eS2µVý<¤é÷ä)ƒE“U_¨/ƒ	À¶ j«!ÛäU*_A½­CcNRÓ¨Ó{`õ„ ß{ZUšÝ£>:™Ý/}éKC>ŸÅ·U†¥ÁJtë<´lµo}Ð6€¶BOÉ9o\nM--¶r 4œWAÏ4JðXôH!zyZÂ´\0iýÖi)<*gðq¨…àûïÿþï¤a²æƒÑx¼Æ¦—B5ùõ:¿&?8ÿQkËEÂ’gÒJ”´¶äõôÐÔÊ=àYiÛúŠV|O{éš@çç€Þ<c7¶VùÝ2÷¥Æ\'ç\nñ9ÏyNòù8Î—Í®Ô|Vƒ²´L4]È¹Ü¦Fe•¡ËÎ\Z/P—Wj %7Àô„¡3ÑÌÐ-P ‘¯5Žåsµ\r%ógúIÝ	Ä{6!ìžfAÀø°z„8k–mù}±Òç£Ù¥ÏÇq¾\r6$Í§Á\'éŽbé»Çû&Ÿ«É-*Å±ê¡ çb@ÉÕ’q×JTFÛ`Óú®ÉàNØµ\ra×bŒÖ>WÏˆÐCìÍS¯¥ßéq5}•~lß<ô	ˆ§½èŽ#œÿqàš\"¬Úˆ~¸IûÊ@ÀT÷Ýw_ÓíÞ½;ì¹Ï}nÒ|ß—¿üåÚìZ³?²žÖüq›ßm|3Ï‡Ô@–àÉZ°Í¢_¯<w&DGÖZB <¥<­’žÍìD\\¶ñà#Ç–VæR´\\Æë„„©!€“½Á…HÁ|7»qv\ZxÙÇ\rkû™x2ðÖc·o–ìáÒ³ðqÚŒiŽ9æ¬[·.m.ºé¦›’ÖËÓkÒçã§°æ“–ÇBhÊ‡¶dÓÆmÑrÓyjzJæŸß[Š!MþˆEˆÇ4™Pj°í[Ð{þûw\nð§mˆal$Þ¼•¶úÌú\"Èxs3ÀòÕÀÚ\0\\CÍÄ}ÂÁ.ûÂÒU5mR—)êLMGžzê©xÄ#‘zµ|Ï©5>¿üòËqþùç§•-º·[WP»\n¥¹Ö\rßëXÚ5wI>VÝ½ß(hÝ®Ö@Úw³†<íæ	«Ô\Zt+ªÕ=aD³¹ï¡?ü&Âçÿ°öàA¾O*0Ôëõ’*FUV\'×qn\ZØ=…xög€\'ÖyÅà—ËV9ÜMLõ¼k×.œtÒI8ì°ÃpÇwÔÂäÎór~—jF‹—’þ’ÿf5ø_ƒÚËCË\\ûy^:‹KŽ:ž|—xbù0@ÓÆ™õ\0æUZ†‘–™ôV@œÝ…±{·\0›7¢‡Ð_lÀê G¿?3à:!¥O¦7—•f\n*7qÇ]{1°éUÀÄ8pá§íw{ìS›y‹‰ú¹õ>átÐAi¨EÖ•\nèî¿ÿþØ¸qc2»z¹“%8ÉKo¿oî¨HÚ,ºµ\\tþ#ŠÀ\0ÔÝm\ZM]8*t!\Zmæ«ÂCÌ¡2£‰! &K—#.^>Ô™èkÂA§BÓõäŸËNÈÒ=ï»O¼.ùŠX¹\Zaõþˆ4Ï\r³ø%Cyš ¡lÒ9x>–|_’FKk–‚e)-Z-þxnC×Ž•YIcI•]Zé«[T£R‹U‹/8Íò».cŒ??‹0¹qrymÆ{ì˜8Ló4ž%pžZ@óz÷ÝwcŸ}öI¬µøI3¼eË–úÚúM–\\4ˆ,Ó\\¢Ù{ç)!M6Ã^c²ÂÈLÈý\r€Kš°\rsïü5{ÑN£à	•9\\¦r	pVYYû]vÙeiž— \\¼x1–/_ž¾ÿú×¿Æ5×\\“~Gc_”V²xÚVí×yñ,æi9/¯(:=0äÚÄ³n)‚åÈóG$!Þ\næ’ÖÆY1uùCt…º3¡›é‘€Éß½¹TË9¶4¨¥Æ\"Ó-[¶,i9³pfíÚµÉÿûÙÏ~–: ¨4¥u¦Šä•œÑ#=&yÓF“ixyYñK\rÆâe	sè–ˆƒ((ÁiFzæ´ô]V<å¡œâ°ŸgÑ#I©mü$KÓ4å+óâßªU«’üÆ7¾Õ«W§Aé;v`éÒ¥iXv\Zò\n“’ñÊ‘ô[Ï,¾4™HK–x_Ê§	ŒÝ`´š&P–â¶%´‘q Ù·\rN…² -aÀh0M4”\ZÁÂ\0÷oðã‚|GPFµŒÌÒ<Vù%ZKšª)ööC[ .JÒÓÖ5\Zðò6ùŠÑSò\n6Í®zY¶*^¿T†~f}/ÕC¾kÒV]hnÙùðü9/_YGowZÖFrM[é·¯ôÎãŸþ^*ÛÜÒ¦\0«U”l½•‡çoDÝ	ˆpó³Lx“çÕM§·\0å=+¹*šVM¯õÛÊË{Þ¦Ñ·‹Õ@½òå™9ºÎM–$‡.6_WišÐïmVƒ¹!ônƒp„[!úó¬ÈJ‰Î±\\ÒŽþ€0ªƒqèb./Ts¶8æ\\6ÇÿÇÿ¶OÓ3ˆÝqt`Î[¦O½’Äc¸Ç¼&—ÄM”4Y@Õõ²|=¨-¬–¿guv¬ºëÆwüÆÚ4R†îü+>kÐ¡²€A±?á¯ÃÈ¼lä|lD¬f+F	•‡\'Ë¯ž±uÍLG?8ïçiA[ó`iâ€‚Ñc.…&sÙÆ]i«!dü’v“K¶t|˜V%÷…†²7M[.ö>¤úQË¾ÿ[|„d†ƒŸQ¾¸oƒé/OÝ²T+Xâð°\\g¡üì;W¸|íP%´iÕL¢Ñëé<!–ìÒ3«ì’PJN=0ªÕ-ç^FçÝÆ_ÓeZnL‰NÍ£&Mo…îØ»N”d¤	ý!§?2·&éeêtqT\0#¾c=Ìbû&5¸f{ˆ+V«Ö#8SeZÀj½ú¬è0ÖEœÙ°õ¶4§Wí,ZÌÏ¹ ²žçPå6™7K[5iè6ZÎ¢KÏ-k µ1ÃM~x‰Þ.\'à‡goJgœÆåÒÌÝ)à:<ha˜Ú¡Z¹\"ãäÖåT,fUX\rÇ¤Ï™]ƒô•¿X¿Ë¯žEA{ò+ç>i‚þÎm\\xÜ€‰.ÂÏ¿‰85Ý_ŠU-FÈé=Ák@5&ª5˜6‹Ú/¶4§å!†Ÿ4\r0ÀÕdÞu9q¬ÆÔ&d\Z»ieˆ,Hß×VÙôWÇ\ZA’W¡ä8ƒeSCŽu‚dÕ¡‘¶Z?U OX¨müÀ\'ÃŸR³FåcÎÏ\0»¶#žýYÄç½ ŸÕwN>ö\"„é)„‰þBK›Z€Ð-(ê¸MæÍ*Ó2Ã\ZÐÖä€Ì×µLNKAjMKzîMÒ€óoºD1­­Þ\r®&#²¶	õäÄ\'ýÁ”Ç¨ròÿò£^-”¼´^æ „i˜lQêÐ¯¡w¹S5?ƒ8¹8d?à¶*É‰Ç?>¸â<Ä5š~”fðHé-§ð¬üôû6(aë©P\0%Mf•où¢Mà<?2¤õ€×ÿtˆ€Žã ‡¡or8e,a,ý´ÕIIš².õûÔ\ZG 5èÕ ªWìpã@Îkn!ö×ž\r¬©Ð¿Ûî\0Æ0L›×¦QKÚÍëÀDãŠ­šòÑôz¦T‡¶&Ó\n5ÕÖ³nçs¯®´C¬ÕS\'3¼ÚO‘ü=©¶â`Ì/fU_#e0žW4›fdÍÙ7ë!o‡Ì@qZJGšš±NEfL.Aí\"T íõ7;\0+hè›ày„©ÝÀ\r?^ö/ˆ‹&€/}ØøK`åº\"3µ/\'Ÿ7]Öâù‚–æ°L åãYþ—®e†=¬µg©>_¼x¥R8êÀµÛ°| I†‰ìõT+òé²™\nµ¶	Ìù·ìíJÆw2(+ÞÓÎ´ÊÏãdÍÊ5èMô{©Þ¬¨†|¦…~ƒºçV`Å~ˆã]àÎ›Òjè8ÖMG§·4ü]Š(ë»uó“x™Þ:ŒÉêX,èµE*œ™8ãè\n)ùÞj@Õ³ÝÞ1gåèµz‹õK8ÿÆ^T+ä‡Æ1°ƒrsP\rr>bð/VÝ	àÎ:ÓÛ€M×\0»vô÷ó:‚(dXPÕ(úªýÝÛ¦{ˆ{îWÏàXÂÑ‚…\n@Ôtj\Z£\ZÞ*NË[~ª¥Ù¬xmLu‰Çmi‰sØùq;ïŠ~:âÅ·÷7W&ŸítþïÛ€oÿ+°÷ƒFî&kbféî´<!ßË`1´ÔÑÐô5dó=\r({¼p\Zƒü^ª‹×AñÒëòò\"‰63I†ÞÑí¾û”$é”Afãð·ÊÿêÔSuùQI3?IQþ¨üÀžÐ@Ô›ÛïÄü/Ö=ØeU9«âmCÉq·LÎ?8âÒ\\iÓ¼ú<Xõ7L^£¿¶pÒj×¤›üŸXmgaH	éÈ!›3µ\\*Vƒ×A£¼î—WÁE@åTíÍ÷n¦¦*@Ž:Öm©Í\Z^ðWl\'ÚX‰âÅƒmÓ9ØMAk¾R}Jï´Îà·§YÛÑj0Ý8¹²Ÿ™°ÅpÇWä‚z6\"g\ZÅè\\\Z\0ì\r¥ÌjD3ÿzPÐf$æfû»àªÙ	kÂ]VÎr´Â!Ú\n‚Ðù[>c	\\mýÈ6‚NcJ¬È§R#öÌ·çcZ.NÉ¢ oË´Ô²—(TKÈóu–TÒ:-¸!­Û=HSèÁiXõ²|¾kåµU®eª-\rÜÔH¬5R÷j¾iv×&ôæf·ÆºèNî74òP·ôC½kÂ \Z–•W?ò;í¿v½V¯+­ßY+ù\ZhV‡k;òÅôŸ$}\Z :”Û¢R(ÎãùiÑÐšŸƒ<:ˆóÓ˜Ùµ	+×?+÷Zz~ÏÆ¯bÇßÀ¢¥!†n#øšžk^yÏ<àÉºêÎÊÈ¾`)`mïsAú¢”RðV[”4DÇDŽKZÎ}‰QZØ%lýÖ“ùM\0óžy\0°L·õN×]¾›Ûu3Ö>øMØÿ˜·€GçðéšCÎÄÆŸ¼[þð¯èN®@§3–ø9Ÿòès·Ÿ¤§ÞÏ;»Õœ»Ã¸êQä¡1äJ2.º‹ÖñòðžŽßµki@H%á6™\'«]fôKêù`ÏD6LßhÿK‡¶æºIS,Äi2ÇPtÍMoÆ’ÕÇaýoI}¶™íýç‹–ûõ^ÌMoAov+:ãË«ÓLŒÍ]b,6`\0°º§T§Uòu=äxH§ƒù™û0½ã·K‡è–rè¢°ÇTë$ùÒrí³´õÇP/$­ß¤#û‚qŠ©%0K˜šÏüI?ÅÚë`ùtú™.Óª«æ‘÷Î«c~?7}–îõ$t§ck¬LßŒM\0yÊg†vÊ‘ˆòšñÎ±XHH‹¦æ€éÀ­?}!îÛüÊ\'mø]-(Ë¿jcºJZJh:½íÓõç€;i&%Ö³–9‚#LøU«<ˆÚqå^ƒÙ\Zc¨Çƒ¡õ]§)iL+_‹ßCe-ÆìÎ›Sít@ã¹žü}ÇÕ_ÃÌÎ›16¾\\8ÕbÍd]`=^64V»?j•Q( ”ã½™­X²æ8ìùÀc1¾ä@ÌÏï:Pòª~ni>j¹iÚÒ~%€ZjÍ¨\\›JQ!©r\rfƒUbÃ­8š?ç—ûqé¸Ï\"l»\rq¿£xDâ?Vì\r¤µ€åíVÝÚÆikn½|50Ç¯ÇöÛÎÁ½›ÎÆêC‰éíýŠ/^l¹örÜté³“_Ø_Ôç9„¬7ºl¦ó®³6C½¾³>yv$¿~˜Þ±ëùj¬yÐ±èÍïBøi·§ØšªÄÝºu|Ë¿jBiøƒ¶dûV„ÛïÂuÙ]”_9.A\023ª#NYHv_¸ì~çnÄÓÞŒø’·qÌñœ!\\ðÎô½Óš¾³Ž­hÚÄ/¹<ÿµÅèŒ-Aon;nýÅ07ýv,Ùóž¼Ž{n¼·_ý6L,Ûã‹÷NkÎJ\ZU—ÕÆ}(åÂõè.^—O;.Ö«+k\"­ù=iF´€`€R­4\\¡AÉÏ±ùÙþŽºÓ_‰ù}ˆ°lÕ°ºƒôcëó†ª(\Zf¯j³\'ã#}Ü ½¸ö‡ˆ×^Š¸z?“«nž ¼8¥ŽOPó©–O™ÃÀúÌ£»x=ævoÆÍ?})&–î\"¦ï»îJŒOî“œ1ÏM))+xnÎHš ßÖG–ÛÕL±€dùmZ£YŒÔq£ºà$\Z\'Àçt±.0¹áÛïE8î)ÀšôÏvFÕóªLJGø-}“ A“{r\"ï0Ð$Ñ¼ÌU‰&Ø@Ñ­·®‡î„Xõ:(VžraDC×€9ˆ©7‹î¢5èŒ¯ÄüìŽÄËñ%¤3øÎ¢«D‡–ƒ®‡~ß¤é½WµXÒF²P‹™0Ù)Ð¹LcUÂ­ÿ–­Eøù9»øSˆcßSzì2ƒÒ2ªŸÑÿÛ¹½¼ñeoHgDã+_®½au	Ü-f{¾]Ów·sdÉÚh`ýºãËE<;×°,Y4iz­Í‡xT[©á>ƒæ•žÆƒ1DaU@3º´s_®ó½9Ä•ë—‹•:bëp…â`/‰ìÍå5j>ya~o½ñæ«úR¯ú6â’Uý%ù±7D”æ³¡yáÐK·ŽŒW®ç{y5ù§%­­ËÒuNçwºbZ’/ü2­É,b½ûxå{+Öš2Žu÷­|×Ë‘¦ZöÜz½A¯ÍbZ¬zw˜ÝEˆ{\0üþ\"`nØs}ò¹è!˜¯M¤>™KÖ¡IÀ:ÏÒwCUq¦DK ÷Ü(ý»¤\\¬gÅrC>á,Ž€pÈÔëÌJ>_S+·ÀÃd[å7	DÒ–‡‹‚Zoç†Ü=KÓTñ¸â¦:ÝT–)ó\Zò½E»m5¡Åc( Èü­Æ­éÐé­ Ó•|:Ë\"4jÛú\0Zß¯®UŠƒ,XÆÉG]DuÏ®ÔX²£!¦Ÿ{‡æXi=º´ðäu¢^(ÕÕkÝ^\\ÝªÛj>«®2ï6ùX\rÁ2Õmòòõ~auUBò¯Sr&¡.BÖÄ´©œ¥A¼uÎÎßÒ¨¡ZÖÄ$«õ•âXàò,‚WoÀð4ŒNWÊWkC\Z€O¾×õ/™ë&ºû?ê\0F1\"w¤ËÈÕ.òo½BÛå ÏŒ“Y-Ìjùú{éh5«Ñè\r>%ýž ¡–YYÀ(¥-Îª¿§I=àxåÉº[ù5¿P/ýè31VHÇÐÕÇ³Zþ…6•zS%æËƒ¹ï¼óÎú·laž&±Z¤u¹Ö¢:­µ|I^®—ŸeíÉw<ÅÔŒ5ØÞd~e¹–_V2Ù:ï6««-ÿÍ2¥š&Ï—ÌßyéÏµÎ|²‚ÖœõU5«î#sÁ²ÕKAI`eä÷rê*‚iŽ?þxì»ï¾éw4VÝz—Ã¨˜\'DK@lÞucZ Ö/\r\0ÏDßß¯mhc–›èhÒdš·<H×ŒñJ	žqÍc†uz_+—{Îò3ÐZ\'\'3× “š#_EÊßù**þ¾ë®»pÜqÇáø\0~ñ‹_ŒÜ´-Á•+µVîÕZ kb¸•wÍSz¯yÒÆÿ+™Í6ZÑÓ¸M´zõòò±âðšY^1ñ™Ï|ïyÏ{pðÁÅñxÔAš\':ÝÈ5\rQLåï<0öÙêáüž`¤æ»úê«ñüç??Ï|JwwèûÎd™ÒÇ“àÒ>ª4·9km.S23—Ä”—Ô žæÔü³«…¡i(Í“[ùyÕ&UÄ–;të­·âSŸú8à\0øVˆ#~÷èÐ‘Lß•fL:åÚDÊJZ÷¡I\r\Zª›!y)Èûpy3µ*YƒÊ”ÃüÖ ÒŒ—Hƒ5×3»	9~>ÉÞ:{¯­öX¨öÓ¼·ò÷òÌÏ½ãyBƒ®-ª›?KùÀàýPü8ÞüâüÎ>ú‘úi¢Xš‰¶NÐ-?k>	XÏQÕUõAô:¥oÆx¼ì1Ërƒ\ZB°|;]¦f„ÖdYXcbàYÒ*SHí¤…g	»¤´öÌïõ’iõ@êXÏÔX<¶À8¦åu(<—^3Ÿq tÓ”hÍËÐŸ/67%Y¾ŽeŠ´\0$ˆµ‰€\"ZkŸ\\iÞ(Ä«Ly¥)¯¼ÊñdyšÑ™©Ö,ˆ \rÌ2x›9Ÿ¯X±\"•M:<&[à£“~ýõ×\'çf‹é5á€Ò*G‰ù’/¼öCIŸRÓ{Á’ƒWŽ`’ÞQ3>ƒÐ™L³›ë7|\0ëù¾jÉ6äðº£‰m¤ŸYkµï&	–Ú2¨q°¬Õ¨îy­Þ¯~õ«‰áaÎ\'k\'ÉK;kz3.|Ç2Þõ®w%àœwÞyøþ÷¿=÷ÜÓ„š¬¿ú«¿J·d^pÁ#éÑ`–½¸¹>·ß~;Î8ãŒäÎ|á_HŸPÉ\nú}ÉhãÂÑ~C~Ý¢½°këÏpÇÕ_Ggl– ÆJádðYk>U\nÕ[h`	^%ªýÉœßöíÛñ°‡=¯|å+qÕUWáW¿úU\ZƒÊéåŒ‡¾nPš×b4ãnÝºOyÊSpúé§§Ó?þã?âÛßþv*+Èëºèß,›÷Â½ímoÃ/ùK|ìc«h¹%^°,K›6mÂË_þr<ä!I#Ù§¶\Z ¥,+Ôæ·§é¢ò«‡\0¸x=vo»·\\þÝtßä‰\ZAtB´€ô‚k0ØHP3Ú¿óÌ\ZßÓ´0°“;Áèe[thÇê%kf²Œ©©©d†	vÞõ[:éÉ8ÃÄÄn»í¶4ðÎïž?ìåY2Å¬óÜ¼ys¢‘ß›‚§é´Õh«•­=ÙVž©˜E§»‹ºËjú{ùü \n€ùÞ˜º¢[SÏÓà˜#Ídm*½àµ6Í «s¤ƒ~îm)šŠšöCúøÀ¦Û-iö³ö+Cò¥Ô0= hÿKÏ_+ùÂmxbOËYõÔîšE{]v:´Sõ|;êh•~\'gÁKò5Q“¬÷²²œlú‹•y2¾îxh&êr6ßÔxò9ÓœýÇüGê8ðnß½öÚ«ÖÄ²îù™œÐnŠÌ›ùÈùnà’	–V\"÷@­†Þ<Yv®Ÿ^t|)\0\0 \0IDAT·\ZYÊ>Ë óÇ‹«¿kÙXÀŒjB¦šŠÓh­§+©—ï=pBtñ9ØÉ+íÙóätý±ƒ:h$>?)DšÊ[n¹%õiŠ˜†éÙkåµ¨dŒGSEmÆrøÉ<î½÷^LNNb¿ýö«…Îøïó¥s/}MþÑÿb9Ùñgíúõë‡–e+ÂŽÍ7Þ˜êÅ÷¤›ùSÛÒÔçÀrYÒÊ´Ì“®ËbÞ,@òÌ¾–	ó`g…ô1-ŸÑ¯æíä‘”q:§ÛÈwÆg<Îý–´¯§ñ=?Wûá\Z¤Cýw™yNd¡Ö\"Hk]°¬8™ú‡?üüãqî¹çâw¿û]ºMüío{Ò>˜¬CÆ’™¯ýëÓÔÓóöñ¿û»¿K~ý#Æc9úÓŸð–·¼Ï{ÞóROúïx~ûÛßâÚk¯Å×¾ö5lØ°üãë2°\'?ùÉé†s‚›ÓPY‹r.”SR¤“i®»îºÔ}èCšò“ãeŒOa²^ìIó=Ëý·û·Ô@8Ô“ý7‚=gÖë¯x~ò“Ÿ¤üÙùúçþç”×Í7ß<âïiM˜¿“–G7‚Óg¤“ÃBt)8Ïz‰Ñí¦8:;MŒûÁ~05VËu‘¾¸~fáCÒ«W\rùéºb^ÆV°ÐíµÐX9¶ø7½éMøÊW¾‚C=4‰ xõ«_ž1l9¶hš¿sÎ9o}ë[“`ÈX\n”=O‡ f<Æ\' O=õTüýßÿ=~ýë_§á‘K/½4ïðÃÇ·¾õ-<ãÏHùfÆøÃžæ®	”<úO-ÆùùçŸ£>\Z^xaú;ùä“qñÅãYÏzVŠ“…BòÙ~ðƒÆeÃ:ûì³ 95IÀ1oj9þ,ÿþïÿž4!‡oØ°þöoÿ6¥åô%¯þoruX>ÁËFtÙe—%\ZX{ól(¬÷ßüÍß$eà’wlˆ¤ï¬³ÎJñÙ°i4€`(\'=£aj-m©S´Ù˜nÍQÆjL.ˆ¡p–ù¦\0N<ñÄ¤¡þó?ÿù—™T?+DáS[¼ìe/jiìÇ?þq<ö±MÚå’K.IÚŽ <é¤“ó84Áa\nÒRkÜpÃ\r8å”S’fyæ3Ÿ™´C®™ÿÅ/~ëÖ­K&yeÀg?Œ½Ù#<2ÑóÍo~ögV×…ùÿô§?Åç?ÿùª<–˜ç»ŸúÔ§â»ßýnÒ24¹ÔJ>ÁÆ:ÐS3³ñ°!¼øÅ/Æç>÷¹”–ü|ä#‰ßüæ7i.–¼¢YÔ<––‡ƒes“\0&Ý¬W¤óï|gâ	Ë\'à¿üå/§qK.4 ÖçìXûºº<+1Jbá@ú±:$PêÖ¤m¼µÔÉóšz©¨455Öë^÷ºTyŽýQRðþð‡S<úlÌÌ Y~Ñ‹^”€@ð‘ÁŒÔQG%mó½ï}/™[ú1™yTfë¦€Él¶vÆ\'Ø(†?øÁ5xtÃá¸ÞsŸûÜôûµ¯}m¢áˆ#ŽHeÓL¿æ5¯Iïžýìg\'óÏ@sFíJð1n¦‘áýïJKºX&ÁÆ±Ç+¯¼2q	<Æáx$Íáã÷¸ä«ÊYl,¬\'ßýùŸÿyÊ›åSÛ“&j?†—¾ô¥ÉìÓR0oÖéþá€Y.“Õù*u:$È´B’qå\"g‰1÷„Tù\\Š¿åú¾&Í\'Wµ\0{ï½wÒ„ü.g:¨É™6/f` É¤‰êŸi~ÿûß\'óI\'>72‚\Zˆ¦ÏÎ?5;*5¯×2Øq OÇr™Ím6Ÿ	ó¢VÌŸY£g°|Ö—Âe}©u‡Ô„¨´¼ä%‡†rÝÙh-da²j/ÒH€ô¨zîl€Ùš5kRüÜÛg ¿¼Ï>û4.8•¦Ê2JSœŸ[c°Z‰Á;!Õ“V³\0Õ]ï’/ÈwdÍJ°õB~—×\ZRóh\'˜¿³©³:HÖÄ{vìåðÅðìWÒç;ì°Ãê¼)à<CÃre>rÁ…¹®ræ‡ `è*P[eºÙ3}úÓŸ^/ÒÐ¾”ùF­MÍF@1ßüœæ˜ô2¯<·žùÕ$ÍOýÜÂ	ŒqÛpíÒuuæº Oê÷ú{ÛÊä¥]V<ýÝóCôd¼7d…Ò¬ßÑ¼ýÅ_üÎ<óÌ‘÷Ôj]tQò©2ƒ%­ÖB_é¨S“òóÝï~w2Õ:Ð”S[r8§Éò9ú»4Ã:P‹r~yi™YA>×+Ä!\Z¿7Ú¡± å-Çn»–©+ª¿ëÐv1¥Œ¦n|›w^¯Ë+×ûnÕ‹.ýKTçAÚÜYà¼/ãÐ³c£iõê›C—ù<íiOK>`–µÏá)ú€Y›éúè:²Æ!«Ð5‘EŽPã²·OsïñNƒ÷âYû·å´µ7Gæ×Õà³\0¡+,ŸåMªúÒªùI†Òds NóŒjìOjŒ\\†•wðKÁÓ–Ì“ttô“hv¥/Kóüæ7¿9ùŸßùÎwú­¹Û­ù Í`®GæÍH“›Á«a¤G=êQi…Îý×Õ<É«´¶Íüb~¶azPæÇEüüìg?krÃ2±9XVÎòýd‡Uw^å\ns™Ù†Ñ‚eÚ“àÓ—ß³_E†Òif×_î-a«Ï«HØQÈ£ð˜–9[±Ü<ÄßÌ\'Ö*¿I«z>ý?Ò“ýU:îücÃaï’ãub¡ï•g,Ÿôf·‚ŸÌ‡¦4æpîÙæú²GÊNBˆg¯–=mòŠüÍÚŒ@Íy@4 šs¾#øÉ¼øÇNËeo÷IOzR»VÉ¿“	½wGúÿyF(ÍÂ“ÞòÆô †^`Øp«5ÈÛ˜RÆ!CØ\n)úVÔ ì±ÑD±hfàà4ãPq•	ÇÝh\nùŒ=Dš\'¦åx\"ÇÿhVÈÜ6KÈ›Ó³ûP˜oxÃRo•c‰œQ –¡öC5ÆF3Ér9ù„\'<Ç{l\Z^a\Zši6¶<ÌgÔN›O8á„Ôq`|ö`Y7‚ˆ¦”ƒË¬yFšXþƒô dò9cÂá‘‚ƒØœõáPyÃôÌó¯ÿú¯Ó»~ô£uoŽ’Ñ ‘ØÚªñöÄ‰2µ8YÆëjb¢êÕZ~•×Qñ€\'ßÑ§¢Ð8SA†<ñ‰OL‚#Ó_õªW¥÷/yÉKÒðµÓPKp6ãŠ+®Hæcj|Ï±AöéŸq@û½ï}o\Z&@(‚\"¿dšÉ@‚š\Z-›´¼âœRsŒ‘4R€~ô£ÓÀ-ùÂ¾0•Ë)3Škô8×ÊÆC0]~ùåÉt’^úeïd¾`ÏëøŸÑyÌcðãÿŸüä\'S£#¸Vj-òˆ\rñIÇH9–Çé=–Íi3.sh‡ÐL÷¾÷½/}g~9Ç)9˜ÍFÏÅ™vžXÿP­ä–óÓ–l-ÀéOÝ!‘ß3ŸõÞ— ÏˆÖ`Ò6]kGÝ³ò±€˜MÁC¿„S]d4ŸSCpp–SHlé9oš;Žàs8„3œÿeþÔ\0ŒÏyZšÉ¼àI ·ã””µGüM“IK±\\‚Â¤ÆÈÏX\Zgí÷Æ7¾1<TvØ >ýéO×„åSSs„¾{¢*ó\"°8‡ÍÙ\rÖ‹&•ñÙkeÝŸ³!Ü=ÈÆÁ)1šwÆgþŒOÍÅŽã³‘ýÓ?ýSšÌ3.lì|ÐÜØÌ3/„`Ã ß8ËÁzQÓ¤ågž~kž×?€sÇ1„?huhS¼\r6l1.ÏèôI©­Ž‰ÔB§vZ\ZÏâ\\([rvÀóÊ\n€Ú€$“©Ýø>o”€\'“)`ú:È¦ XãÐob«æ\'ŸóýÂÌl™Oö)	4¾Ë½D>#\r¹ã‘!}5šAjj!TÃ/¤ƒeÜìÿl6!@I#µ:ã±^,+¯žÉ|eZjrÖƒ´“äKŽOk÷¦dÿ< ­ëƒXÕ’AJþ2-ß1o‚’<åÀwÞ»Í|YV^àª;N4ÝùÈGýl|¬«Bm®½N«3*°£+3òœG«@‹\0§¡¸Ùa%3Øºó`/ßQÀyðU2ŽBå» 73ŸÉÎ?ó«’uëËƒ×ò]6\rr?Ï¦d:Ù1b 6\"-ës‹\r-/«¢v!=~º‘´°NŒO0>ÁÈxxÀêÍR’ol äQ\\Îk\rež\nËaŒÕ&+vF$­yì•2Ð{µµKJÆzgñÛëM°å–ü;´\0­…ZÂAõ\0œÓ‘qPZšË¦$Š~kˆ‰qåØZÖ0LïÕ‡‚ÎQµI’nK¦‰4Z¾³U\'¦“uÒB’!ƒG³hšù>OqJ>i9ÈúèÑKÞºÁz2Öuõ0ó0ŒW ›î1ÒJ§+l}×e[åèÎO©3d•£du¬<ÍÞT7M—•wßt=-04Ñ¤ƒµ:e!u\\hÐÀóõîÈ‘CÊ­ßÚK!ç“måØ˜åKÂ§trƒðlê™CµØ¦d•Ûd> \0mMÎ[ñ¬ mKe–´’,[îpôÒêž«¬3efY#Ë4{|¶èÓÏ]Ü$˜¦W¾Ð¡Åïze¬W†~®ßÉ	ÿ6´”Êñ„]â‹§eu>ZX–¹lÓ¬†Z*b&	ê2ìÚºPYÐ—åP–µRÆª‹ÅCK©HºêÓ±¬^†Må\n°\'Åžß\'>ñ	sÁ&¾ÉXØ¼rîO%\r– ^HÙmâ¶¿õÎ£[vò8´ÃñÄì+zÚ¬Iû•\\pä‘Gr)ðr-ËjižêÕU/’=°Ü{õÌaP×pÙ„äaî%—@‹‚–\nÎÂK”>5#¡Lš×pÚ\0š\0£é„sÀ{“ß+Á’‡v85š·h‹SÂ•§ÎC&Øó_tf^ÍÂà 0ÿtás­ß¡êÕq<*V‹V	Æl†-óàµìf¹~¯É”YõÜky’7CPÒrºÊ4%`/h¥:I?’½iŽxƒÉ^¾2Nÿµèº+NWFWÌŠë…,ú€ƒK\Z\"9ØJ\0–NG°ò‡\n£öMÁó­:ÈNSÞÚC‹~­=<™X€lË_/è²½…È¥:X|·dÕ±Ô@¤$¸iüÇRµ!ñžŽbE­Ç<i&¼à™3Ï¯±è´âZïÛt¸,Íè•ïåei3WS1^&¼ívàæ?S[îD‘m•2=´X^ãëÎíº5#ý¯Þ|°3]>Ì)º|Õ)Ëá8½X_Ußç+>4É‰Àô0`èÒ’ž¨ààæøáLbu¯ßë`&,Nôåò{Õ¥3õM™âÖÌü;¿þí=ù\\’þ9ÚÕ_é\n°~\nY¯/ÍdXýë`lÑj„1^‡??\"t}pOÉ4z\'ÀP¥ Ý{7ÂÔÝÀ#NŽ8øÁ7ßÿqÉÒtZ–IJ7Ö!(Fî¥1ô/úY½?°hIÿúÛ‚¶ê ßu—­{F}=ožLß{1jÔÿÞ¿+Tw´%|dAÕ\n´d4\rý–_¨ãTyháy×[ÿÌáE³ýŠöçi{:eÉ¼dÞ~ÖÏº\rÍÁ|Rc$(ç1uçå˜ß};º“ëÓµ¨ÚUÑÌ†\0‚¥á´h	¬MpýôÛ€%{\0¯ù\"À\0G¾¸äSKW¥:ÉT1ß·—ù\'Æ€{ïD¸ìˆ;îN ŒFG£ÉGÌÖª{ðIŸ\\På\Zƒ–›ªCP·Â×\n¥!ä+é5OŠyX´â L³ŽOZˆÃÍ¿ÿn¾ŒÛ!ÿ„îâ}ãìˆ–ë¨[¼àu(äojføŠV¼>1]`n\ZØz°k\rp÷-ÀŽ-@o®_¡Þ©HË1³ñ‰¯EÜ²¸ä“À¢ú1TÙÙg×Dí&u·üîÜšÿÃf¬AvRñÔBÜá«ß„T9WñƒznÝí+ÏÍÎ¢36†±|Ú’`0í’–ªÆ6­P®îŒŸUÚšqæ¦ïÄò}ž†õ‡?!|7_öLÄ¸	ÝÉ}ÓAŒ’Ù^Ç@¾÷ây¦·¤ià\06…ÅË[œ\\ôpà·ýqñò>0Ò±i}K˜4buÛ|m¥x™ã¶)`ï‡‹—ÑNÛ¼R›¯¼ÆÇçÝÛ¯zyåÅúxýX}Ñî!kFõ“Éq$qSbmFúù\rz‡•¿‘ý \r¹,Ôï¦ª%ç‹qéP?žô=àT9UmaÔ\nkø MbÄÜÌ}ÿÃ^@¼ûnx€obãeÏ\0vÝš.‹îÍÏk­¹,ìÖ¦E/Ø2Éw[¶\ZñŽ?\"\\û`ÍÞÀ€¹™Ú×í”4©Wo-í§qxÄ	f^§²6ÁãKú§QéÈýÃÀa·åÚ$÷áÎ‹ÔVA¿îŒšžLøâ±þ•Ý±î ƒP9ÍQtF#;JÀP<I×P§¤0>ÆÏ‰eã˜º7þðÉ\0.Äú#Ð¹\07_ölÌî¼ã“<yktÕk\06ï¹ö-aC	<²Ó@.Ý³g~Ö•o‹útdË(/¤.‡&ú;É©NÎy§þë§é«aù¾_âà¯ßRFŸ×y„Pç“ó¬xQ¦ü]—-ò²âæ¿š†0š^Ç—ñw‰~çæaýÕqÈûÞ&–‚^o\n×ÿàDlùÃo°þÈãñ€ã.ÀüìfwÝ†º¦?¦AÕäÞßaýÌ[óWH.ˆ^åšYCHmèù€uM¬w´•©WYA×s’u:]žf†ö£¬ÊyŒ±Ê,ååñ€ŽEKÈÃ/pÃÅOÂæß]};æç¦0»û6„Îx+·	¥^ea‡†)H¯¾Ã|Ìãƒ¡)-g+ß_G¦â¼J–*ç¨ÉÿAT’arVÁåx—ü+½ÇKÐýg³˜Xr0fwÝ„.>ÀÅXÔ	ˆ87]ú4 Þ’|BˆŽ‰®#„K@\n…i8š4’åVXñFÒ×=H.¦ßÜs×hïYøý˜Hß9’ÖÝÔêYý¾)”zh–ô†\rôvO«GååÕV+ëtmp„ô£g¦nÀM?z\nBøÖq¾…›/{ævoÂøäþ©c¢y£ý¸…hCÝ‰±èÔñ½ºè:y–\'9)3»—­Fxô©ÀÜ.`ùÚ*³\\˜ý=TÀŒUœ0Ð»ï¾á©žé,	Å[´(+ÒÐ¥rò;ï‡6¦ÖÒ€V^ó‹åôhŽI ¼þû\'¢×ûö;òxtÂ¸ñ’Sc¿cBMh¹L¥ÓÆÚ„RãK¡3†¸kÂ®ÀŠ=x©bo~40BOò±-A¸â<à˜€GŸUk¼àñlhà·þ‡¸8›7#uÔQõ®¸’™j2«%@iæêxì²sÅ4ßq_†¼&ÉÁ8ò$\'©9ø._Á•zía“ÿÄ²rzîÍÐ«®­tVà•T3;oärPüø±÷#ŽÀíW]Š›.}:ÆÆ\'ÑÜ/ÕãkÛFZ2™EKÅôÝSˆ1„µû\"Üvâ§8\'D×\"À\ZÞHùvª¹ä{ï@œž&ÆÅ»ÃÃ[:ºæ#âÄÄðr,\r2É$íÄ69À£tü|L·ÆêÆ¡¨¶x TÇŒ€\\øJàq¯0+7ÜX´Yå£:ì1¿í\r]òÈÞñÁ˜™¢Ox\nB‡>áñÉ\'Üøã§»nAwò€\Z„¦`\n~õˆIláü™išÏÞ<ÂÙŸN8ñkç?ýÀŠ½ªÖÏûã‰¡štÈ\Z®­‹V‡±€°kjp<\n ²Tk“Éô˜«C\0p·>7l3ðènBÏ;÷sÖ­E±ÚªÈ´Ìƒ@`Zž/SôB¦åså/ÿxüE>À¼\rCõÉ`!ð Lßw=n¸¸\Z\'<âxt:ßÂÆËž…™©IS²§Ü]´cã<|Ó?\"®‰Ç2žÒúÙÌ.`ÙZàØÇ\0ìÀ?áŒ¾yäüpêLDwl×b=of¿Ç¢ƒ~¾x¸cSù€JdžC_2uÖo\nŸ&Wž³Ì=´Ü|oéî‰«ôõ’ù˜|Œ-ócznìæž\\ëÔL{Þtž¯l`y|Ç=¹LÏMÛú>¯a¸,‘“bŽ½ãœ„Ø#‡/ÀÆËžŠÅ+ÅÄ²1uçÏ13u=ú“…Þg‹ -Œ¥=SX²²?÷ûÉ·#÷h„¯Ÿ\\þÿV¬MCÌiáI%UÞ|ËùäÙi y.KÒ[­J\Zjƒx‘+šÆÇ1b‚-ÿÏ\nMñÚø8}?žÈMæŒCJ0èt:¯œ>olÏ&˜›»¹);Ÿn`Ñ”¿çãàX>O&à3.A\'øä1j^J|	µ9Þˆ›~ôTÄÞW±çAEwòjtíEËÆ0sßm¸íWïÀ½›>›¶›4aÉ2•ø^§åÜíÒUˆ¾ø–Ž#îý 4°.WzÄ\0hö}Àþ­”Ï^\0+¨EúñEG¤ß×È“ƒNÈ°4zT(ì„ÌÏÏ/·„ÝÔ»ô:-¥ÎLù9DMÃk¨íx.\nÄFMŒÏ×–ò„Qj<žÃBPåÍîMÂdz–ÅCÌùŒåS³êãÞ¬0âceÐÜÎî¼al9ùr,]»3Sý(‹–S\0×]ôtLÝýL,Ùˆ÷MZWóÒªßˆ¬×þŠ±˜ ä†±Ò»ç6„Óÿ8òX`Ó¤;YkBrdñÛúÎ0Ù6oÚ1tHy›žßë4éÅÉ@ ð° ž©BDíÅƒÄsÞMNºLŸÝÉÛ\0šz­¨Nf Ödú|]ËoÚiþY„Î\",^ñPŒM¬ªÁÇ°{;0¹°çÁ¯Ä}[~Ö9=°+êÜ¢±v$mÕyÎJgY“%úö$pùEˆßû0°jßêféÿ¨•_,HÎQ’ÉŸ›Ý˜ƒ±Òç³@e¥Ñiõwùž Èwšå¡×;¥+VKõó±4›ù\0ò’ÿª¿3\rÓë3e¼ Af¹	2ÌÏíÀÄ²‡`bé¢Àïú\Zp|ò\0tºKû«U\0=?S¾×uô¦R5 =°êüsÚ~^•ÖäÂÖ­·#n¿!-éƒ\nÕ™\0Íý ¿ôú&Ý¼¦Á{&+Óæ—¦àU\\¬”w²è9é^ˆÎÀ°îYz.‹üNÍ·{Û/1»›`8ô–«Í!¸wÿ½¹Àâ}ü„\n%·ÄÛ´•óó¶µ6É£ŽÃŸÝ	JO,i”‡©€2½‚ „9ÄQb’WÑR™:ÏœÕóö´±uÁŽfB“pÛhQï™Ìclb\rvm»wüæ-è.&WË€¥«m·\\ƒ»®{Æ\'×ðËª/„\\Ú¿M4ûüèõ—c¥¥TÃûM<ÙY´çº\r™`Ë·ƒÑ2¬ÂÚô=¢¼ ñ&Ó¨™V2+\r^ ‰†*Æ—„{nü0æg·cNEgl)vmû-î¼æýIûÉ…¬VÃmò¥%mˆ‡äÌwœ~ëF\ZJyÕiÅ0aßØ¶³$PØ’yè1±Äp\ràR„W¦ÖlÚÄè|K\Z¶äWv&ÊnefßéïL$m»õ3¸÷Ö/¤NÀÜÌÆ\'×¦ç±a«ÇË½ð¬V\Zã#èî¹ñÞÀž{ ì±Ï Wdä/óíï‡éæ}£z_h(?ƒ<Ð†ÎÔ$ÌÉ£yõ€¦+eúF°hhëG•èi¢U\"ú»\'–˜ÆÀøllQHÛ;õJY–>µ¶DOI+V_ïÝŒpÌèpî§€_~qù3]Uè -?ïÙ‰8½abzd¯McÕñ‡fB,çÔ:Â«TaÏñÍßKÓc¥|õ5V¹ÚÜxÚÍª‹.ÛÒüMÖÀÓº\Z”1†z¸E7à¦5V™o,-Ø{]¹7Â+?\nðæ±ƒÎ\0~ø±4ÓŠólf\re”?g§€ÃŸ„pÍÅè©Uùm:4P\09ž-ªî¹¬¤UyÍ”ÒI[ž€Jù–Ô¸~W2MàÉÁ:ç¯ä£EÃ²|ŸFmåü¶â<šßÃø\"ô¦§€[oAç n¼qëíÀÌîáú¡ßÙHßõKã]àïDüãk‹u.…‘NHÉ²¡?-áK&µñ·äó NW—q­’?­“Û6\rb/÷Þ«ëBÍºç/éò¬Æ®òJ«Ðãn¶©­ˆ9ó…ð‹ownL»ÜbŠ>˜6Ëy§CÜ3Mäm¯2Å{îÛSŠón‘U¿LS}8‘ÅÀRËÒÏ!îØ€sT™Œo14‡¼ÄIè\Z0mü¯1è‹Xtü’m£]--Ø”¯Î»×²C¿iª—¯A¼gzßú5:{í‹ð€#Òñ\ZšÆÌý8\\@ÿ#»DiCûèæ’¿%Y\"ßåcIM #kÿD‚I¦·´£É,Z89M^·—çˆµ\0-AY¡ ¦…JA7,/Ÿ6&VkO-`‹¿¥0ôž`ãò«Å+úTççFÊ–\nÅÓÆºlïlD]­„:9‘¾ÑZS2ÕºP·t²g~µY¥fâÂ&_K\rnm’uú6k›Ì¸ÌÏ*_¿oeéw\r²,-‹>ùÎK§Ÿ[Ø(5DY^G›6¯ OciÂ¥-­j¸Tá}\'ÆÿFhÒ@¥gpÀèùn:^©AXtéŽ åiú- À8fO—[W‰~]Žà!:,DgVò±ä§¥Í¬ÊÀa0œCszy§Y)ý®ÄDÏ§jª·|n™‹ÏzX¼óÒ—,G§–Q¬¦*›ö	7Ñ¥MqT~¾Uý»cUHgj1Jk;\r6yÞàÿDkY\Z´dÂ­g%¦–\Z•§Å¯¶õ³Ñ¤=Íë½ó@j™ÿ’yÔ=lKY ·\ZDIP3FƒÎ²óV–¿Q2Vëñâ{ô”|‹N+”„®élc:›ê ÇKš¢éYSÝ´K¤ó³~”,¤‡‡|ŸUn‰ášË/±\nkjÍù=.HµÊÎÛ6QíMÅ!\0\0,IDATÉ×[éÝk’‰ù`s—ÖZ\\‚/wÒYyé4Z+[\0°ø£ë­óÓéõgÐ<^h`iEÞsr½åÙ‡\ZÀM4æü\\\0f‚óF Ký¶5=%qÙ1÷uvØaæ¢Ò\\~nM·PZãv|ÆxtPÚtämhÏùøÜÅ•Ñr ·d>¬ètcµ5¼­Ó‡~fY\ný]76Lž6Ì÷ÑyVµÉ-1¡0¬´ÅÑž™)ùAž\ZŽÎ®T+’¹‰Kêy¤¥54M¼Á’·‹sÔ–ÔÃö°ª’–Be¹+×°j-h1ßª¿œG—‚·,FÉB4i’’Öj#+x.Q“Ûä™é’Ï§éîZ…èO(U®	ôÌOI“Èx4¥Ü“Á+÷åé	2ö€ù—µãñÇ_ï¶òÌ{=xÕ¿¾¥Û\nùj1¹•Sk©Ñ¸+Îªt9V¶´kTS“Ò<jm£éóÌ¾ånxZÖ“©gæuýêÕ0zÙwŒ†%íÜêÖ£¡C2GÑƒÎiò=!¡ºb4;Ók1‚`eü|-k\0ahD^]dÝs:KãkÀèxÒ¯òÊ±ò„—~fiMO“zuÔõÓq-žyV¯Æ%œF¯YÏÏiÏõq=…å™”Råe¡:	Ak•Â6nÅ½@æÕÔ@tÝt]bµAJúEV½¬#GdÚ’ïÖ&xJÃÓ‚0´’ææ¥Œ§ýë&º5È;–¹+eÒ$h/È÷úð K{zLÓ•Ðe[´7åQuíçñÍ3å\Zhšö&Þ6Y—¶¦^óB7\Z¯áé¡£¬¬ôð:K±\r•¨ÍžÕZ¥f²\njÛzµF´ž[L(™%©Í¬üK‚³˜í™/«èüu~M|òÒZõÍ2Yü(50ëÊ-‹—^hòõò9­I­íµ#GôÊÖ+},]¡6àò\0#ÇŽ<æKâeÅ½^¤ž–ôèÖ.…Î»Iy )ig¯aèwÚäih!ABËHÓfÕ£¤\\šê«AÜñu1´\'\0ÏdÈ4š(y‹wI£yBð*]bJ“KÑ¤i-óí ä.ÈtšGp-7D_þ-ËÐã“mºŒ¯<3Œ!%k$ ÉÍèhtêJ*iAë}[Ólµ¶ ŽhÓiJŸ%À4É+«ÔðîO(ñEËÅÒÐ%Za€GÆñÜýLò9ªAô&°kÚ3=Ì/™±Çô§Í5UºÜ’ùôZ¦•—§Ic6½ƒu. ¢Ñk¬Úï³´<„À`\0IçãÅÑüÐï›ê¨Ý ¿Ô~Vü!+«	l.«R’8Ëœ—@ê½‡juyÆK×¤]ÛÖAÓ®™/—2éx(Ú4MËýÑ¤Z¸h4ï,Ð[æ_†¬T¼!%OÖ¥×#ë·n™(kŽUê–î¿Õ¢Jsº:èôÚ|è°-m¹Zx–ÖÖÏ›¬‡ümi©I->y\0‘õ°x«µ—§œdJŠËú^ƒ¸d~=“WbÀzùË8¥U#)¿I“–òÐ‚”–=÷’V·ê(C©ž%wÅ¶þí5ô,Œ®g—ƒKþÈò¬Ù\rÝ±ôLvþ]ßýbU²I#ÊøM­X£èåi§ãš\0×¨%šµÿb•ÓÆ¿Ñ‚õ‚.³rüÜÐS’eY’¾<æ+ÓèU:P²´è²¬(GÊµ2…zµ5–Ÿ¤ƒ¢fŒWAM“—~çÅñ4{	(MCG^]›Ì½ô…ÔÏˆeƒ\Z:ñÎôö][´x\rÍÒü\Z|µ,©wÙ\",Õí1ØSãmüÁà`\0¾TyOØ%SfÅÑ[JfÎkù¥rKÚ¯H\0òòÓ.†B±‚Å‹&\ríñ88óãC0J{f--ª—•æ•­™ÿ«Ô0J‚(å#CÓP’U^PršÜ£.¹VY–¹•ÊBO‹i:¥ÙÍ4çgre’eú%Oõ8 ®“,j@”½`]Ù6¦ÍctTþI©u{y{¡IóÂ®Œã™Â²ÜOã@¦TvI;Z:kvÊ3·½)V¿´8AËÓ:D~æƒ$ˆ‘Ç=-¡5cÛVî1I/‡²Ô¸Õâu…-ËçVë·òòo=Ó|ÉŸ¥£Š­|›êaÑa)Dk‘ª–‰®[ŽG÷)oÕòóx¨W„Cá&¯Ï”t¤¥úžF°B©µ@µ¨Ò²z™Î¸¿D›Uiïgî¬üò§µ’¤IÓXÏ<\raÉAº3Ös\rRI3-Y(0ëý ºÎ:}î1{Ç6‡jþZƒ=ôoLË­Š·aVÉ—º?A3¤Ét[Á2_–Õy6ÞJëiâ6Ú­t`.7¨9Ô&Y.…þ,•åY>Ù±Ôù7mLÊ¾Ÿòy—sSÒŸ:ÎrY!]AÍ$ÏtÑ»*1Ö«„6Wž–hÊ·\r-My–Ö@j¿¯IÚy¾¥6óºë»UgÏLkm)é±\Z’ŠÒôz·	èxC\rØñÿÓx/^U\0\0\0\0IEND®B`‚','2022-01-11','Imagine fieeeeeef.\nloosd\nsdf\nMeeeeeM'),(2,'daniel.hiebeler@student.htldornbirn.at','majo','$2b$04$UMfL9JXMeN0IQ8e5.ARbqOHwUVRsKmNcqKwsPzIoDYagnstw0Db5y','',1,'Mathias','Johannsen','','','','',0,'Austria','','','','ÿØÿà\0JFIF\0,,\0\0ÿá\0VExif\0\0MM\0*\0\0\0\0\Z\0\0\0\0\0\0\0>\0\0\0\0\0\0\0F(\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0,\0\0\0\0\0,\0\0\0ÿí\0,Photoshop 3.0\08BIM\0\0\0\0\0Z\0%G\0\0\0\0ÿáhttp://ns.adobe.com/xap/1.0/\0<?xpacket begin=\'ï»¿\' id=\'W5M0MpCehiHzreSzNTczkc9d\'?>\n<x:xmpmeta xmlns:x=\'adobe:ns:meta/\' x:xmptk=\'Image::ExifTool 11.88\'>\n<rdf:RDF xmlns:rdf=\'http://www.w3.org/1999/02/22-rdf-syntax-ns#\'>\n\n <rdf:Description rdf:about=\'\'\n  xmlns:tiff=\'http://ns.adobe.com/tiff/1.0/\'>\n  <tiff:ResolutionUnit>2</tiff:ResolutionUnit>\n  <tiff:XResolution>300/1</tiff:XResolution>\n  <tiff:YResolution>300/1</tiff:YResolution>\n </rdf:Description>\n\n <rdf:Description rdf:about=\'\'\n  xmlns:xmpMM=\'http://ns.adobe.com/xap/1.0/mm/\'>\n  <xmpMM:DocumentID>adobe:docid:stock:9f85673c-12d1-490e-986f-b041b3d63738</xmpMM:DocumentID>\n  <xmpMM:InstanceID>xmp.iid:1ac5da1c-3984-4ea7-9a1b-f2733998a928</xmpMM:InstanceID>\n </rdf:Description>\n</rdf:RDF>\n</x:xmpmeta>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n<?xpacket end=\'w\'?>ÿÛ\0C\0	\Z!\Z\"$\"$ÿÛ\0CÿÀ\0hh\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0;\0	\0\0\0\0\0!1AT“\"Uaq‘’Ñ$BRr¡±Á#3bQÂ2¢²ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÚ\0\0\0?\0ýD¤€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\00€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ãÔu,<\n~³z)«²ˆçTþD*½™ÒËÕLÓ‡EÙUÉò§Ý›Q—µÝZìóÍ¹OªˆŠfÆVŽ)©o¿õù>$­öuÝZ×VmÊ½UÄUûº“Âéeêf)ÌÆ¢¸ûÖçÉŸtò#sV;RÃÏ§ê×¢ª£®‰åT~I®À\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0V5î’yU§U1Ê«Ýq‡æÜÆnªµÕUuÍuÕ5UTï33¼Ê’À\0\0\03Eu[®+¢©¦¨âbv˜«@é—U8ÚQ<©½Õø¾iÜVjÎÆ€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0­ÒÝbbªôìZöÛ•êãÿ\0˜þ}ÍÌfê¬¤€\0\0\0\0\0-=Ö&j§NÊ¯}ùY®gÿ\0Yþ=ÉÜVjÒÆ€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#ºAŸÃôÚîÓ1ôµy–ãý§·òë3\ryüÌÌÌÌÌÌó™žÕ¡€\0\0\0\0\0\0f&bbbf&9ÄÇ`=£ùüCM¢íSKO™r?Ú;>´n/\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)}5Ê›Ú8Ñ>mŠvÛý§œþ›+¨°\0\0\0\0\0\0\0Ý	Ê›:XÓ>múvˆÿ\0hçË5¸º%@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0GX<×R»7õ›ÓöîÕ?ªñ.q€\0\0\0\0\0\0\0èÓ.ÍCôOþiŸÔn=+¶a\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\'ª}€òùëŸjÐÀ\0\0\0\0\0\0\04òª= õ\nyÄ{¶@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0:Áæ9VæÖUëS×EuSî™Z\ZÀ\0\0\0\0\0\0\01-ÍÜ«V£œ×rš}òNž¹BÀ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¥¸Ó­Ýª#joD\\Ï¯õ…buÖ\0\0\0\0\0\0\0[¢XÓ‘­ZªczlÄÜŸË«õ–kq|J€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0L0g+Nþ¢Ý;ÜÇÞ®]´öüÛŒÜRT\0\0\0\0\0\0\0]ºƒ8ºtä\\®dmW²žÏšuY‰Æ4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0c³iæ\n/It©Óò¦åª~­vw¢~ìýß’³S¸ˆk\0\0\0\0\0\0ýÒ§PÊúK´ýZÔï\\ýéû¿6n·1zŽQ´rJ™\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¬«rlWbý]ºãi‰\\ÑoéÕÍtïw\ZgÍ¹·Wª¯øVjwM`\0\0\0\0%t-þ¥\\WVö±¢|ë›uú©ÿ\0–n·2¯¶-ccÑbÅEº#hˆJ›@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ª˜ª™¦¨‰¦ci‰âA^Õ:/bôÍÌ\ZâÅsö\'ìí†æ²+¹ºF£‰3ôØµÍ1öè*Ÿ|6²8{vík\0=@îÂÒ5¹¡Å¯ÉŸ·\\y4ûå•±bÒº/bÌÅÌêã\"¸ûÊˆööË+s\ZiŠiŠiˆŠb6ˆˆÚ!d\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#—P4ÞÆÆ½þ\\{7? ÓÂôÝ÷þƒÃ‚‘ºÎ65ŸñcÙ·øhˆà\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0*ªšišªª)¦9ÌÌí\\þ“`cïM+&¸ûœ©÷ÏðØÊ…ÉéN¡rf,ÑfÄvmO•>ùleqW­êµÏ<ûÑøvØ…|ñ}SÒ\nq}SÒ\nq}SÒ\nq}SÒ\nq}SÒ\nq}SÒ\nq}SÒ\nq}SÒ\nq}SÒ\nq}SÒ\nq}SÒ\nú·­êÔO,ûÓø¶ŸÜ…vãt§P·?Þ¦ÍøõÓäÏ¾TÖI°2&)½åcW?>øþYSTÕMTÅTÕS<âbw‰cY\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0~±ªãi¶·»>]Ú£Ì·LóŸ_ª=fe*—ªj™z{ß¹µ½üÛtò¦>~ÙVdMpµ€\0\0\0\0\0\0\0\0\0\0\0í+UÌÓ«ÞÅÍíïçZ«3òöÃ#sbé£ê¸Ú•©›Sä]¦<ûuO8õúãÖ˜¬Ú\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Fkú­½3xÚ»õÿ\0Ž‰ýçÔfDÈ½w\"õw¯W5Ü®wª©íZ\ZÀ\0\0\0\0\0\0\0\0\0\0\0\0\01¯]Ç¿Më5Í(éª;{Ð5[zž4ÌíEú?ÉD~ñêFâójL\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\Z²ò-ââÜÈ½;Qnçä:Ôrîçf\\É½>uSÊ;)ŽÈ…!ÎÐ\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ñ§eÝÁÌ£&ÌùÔÏ8ìª;bFãÑpò-åbÛÈ³;Ñrãä…6€\0\0\0\0\0\0\0\0\0\0\0\0\0\0ªôã6|«XO(þåÏúÇï-åš«© \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0´t6|«¸Ï)þå¿ûGí)Õrµ1 \0\0\0\0\0\0\0\0\0\0\0\0\0Íõl‰ËÔ²27Þ*¹>O²9Gé\nÄ¹ZÀ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ui‰©ãäo´Sr<¯dòŸÑÇ¤%@\0\0\0\0\0\0\0\0\0\0\0\0\0ÑŸsèpr.ýËUOé&4Ž¥ \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0;$—sépl]ûö©ŸÑÆð\0\0\0\0\0\0\0\0\0\0\0\0É¬S]zN]éªªêµTE1ÌÎÆ\nÔ{ŽO‡*©‡Ô{ŽO‡%!Ã5ã“áÉHpÍG¸äørR3Qî9>”‡Ô{ŽO‡%!Ã5ã“áÉHpÍG¸äørR3Qî9>”‡Ô{ŽO‡%!Ã5ã“áÉHpÍG¸äørR3Qî9>”‡Ô{ŽO‡%!Ã5ã“áÉHpÍG¸äørR3Qî9>”‡Ô{ŽO‡%!Ã5ã“áÉHpÍG¸äørR3Qî9>”‡Ô{ŽO‡%!Ã5ã“áÉHpÍG¸äørR3Qî9>”‹æMti8´\\¦ªk¦Õ14Ìm1;%Xë\0\0\0\0\0\0\0\0\0\0\0\0\0\0€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÙ','2022-01-11',''),(3,'noel.hmnn@gmail.com','nohell','$2b$04$H5CHX5xwbYmdJPt86O/FL.fjjQaLlNpScvnNSvJZwcRN9xWgHAyRy','',1,'Noel','Hermann','nohell.at','FIEF-Nohell','NohellSnens','noel_her',0,'Austria','Vorarlberg','','','ÿØÿà\0JFIF\0\0\0\0\0\0ÿÛ\0„\0		\n\n	\n\n\r \Z+!$2\"3*7%\"0\n\r\r\r\"	\"\r#ÿÂ\0b\"\0ÿÄ\02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÚ\0\0\0\0\0öõx^Ñ\"’ËÓ QÝÛ¢Ã‹Äb¼‹VÔo»‚Ó#Í¥F´ã2\Z©¦ËÔ¢\rÉŽpZE[#H^MJ\"ÌQ	ITZôÑHõa„át«ÀìÂÀ¸e²öAxP3XA©NUÑE4ób³=E5ŠÃ/Âæ‹Â¼“Z}ÓÁ¤ŠÝNîd6M·2&kr¸ìMhÑrÈJôQ<«¸p¤œª\n\\­j:Ž]«q=X\"f2(Õó8ŠnzTñ¦Ö¥²x=&‡‹é>†šmDúûP™\\Z%ßºK@¸	Ô*QÓuCšUÉ)X¢ì\'Á¡Ùü–[WŸ¦¶ ‚UîY¤†%J‰û¤iL	a¼…-ÙP¢ÕE‡	·‘Œ•à£¹þÚª•àèP®t¥e¨(&l	¸Á9äs“LÌÕ	.ýjR%å¦9n¾sþgŸª³zéŠm»q‚Oh^P~…?£è°ÚGÈ\\}ÙÖâf‰EÒå B¥O]€©ÎÙæ×^È“4ÅB¹.ÂB¸Ö&\'9Ü7™¯I_=QïW…è;ÞŒ.\rŽÈáz]ßš{N.ŸGã¶3§{#ª\n§w|ÿ\0Lià—6ò}Üš·çÖôÆß/šO/ª$-³K Û}5šËs\0#±KDÛ-4y‹N1ï¦\Z‹)Õ z³0éÌ%‡IÔ„Íž¤²Ý^kÐöEùzôB”9æTŠ‹Ò´©°í#¦\ZŽ°ƒ-#-Å:v¹Öœ-HÑ«%Y$YTö[¤è6£9líS^LŽu}yÅ=%… \n9àŽ™e&ÕéáÇOLÚ\"æ—€ÐOr7C¼””â¼V•çùéky³eë2µ•Ýæ},ggGà§Îˆºàv«u±Ž“!c“:‰JxÙGSL­á^81¦ŸG:fò¬õJµ©¿W‚{¹6©iE7\ZD-HªÖ§*¯ËUÖœ Y¯ZÍ‚W%Žf²c[6Úyë^¢3vñ¿=èðNGQŒ¬†¡¬_¬\"&ƒõ![EÕg«¯\"]Hèã·W¨·V©£Õß&=9ëµf’—Q,Êˆs¶…P»»&AT$«k49­š$¬gOÓ·=Ÿ;kèÍßO—Õ×ÇË¦È˜g˜íÔ)i„šUZSMiz¼@Ì\'Æ\n•á°y\")nŽN‹JUëu6¢–Ãi‚#\0áhT¢l±¨ûHÕä™ž›c$2Ç´.Ž‘˜</Fùe7ÒgÒ?§™µ–u1“†ŒÄÚÎ9x8W•^g3ØùLÞ°©¬—sÖ¾þÜ~x^\\´ò½ê¸ßƒÏ®`¬Ežå]…ªhÇ³2½ÒO©r5\r8¸ùëìRòÄ.ÝÚÆsYµym<y¤îÍ3Ò)‘†óË/TùÅ2EªÍ<1Íx‘îâjgh¨Ø…ÙSj1NŽÎÑê4²ŸuÑHéÍ·JM™¹%i4…Ò77‘Qn™\\ˆvÀ4ÕŽ´ª5hBNe•‚Ó¯`™Åóç“\\øM£cÊzUcOSÙ:Ê¤›Ò•Û†Ü.Ó«\"çôn¼\nà†Qæ¨!‰£]£Vùæ”Èà`IìzT4³]yCWJê&uÐýsª-\0 ž•Ÿfœ6Iùq\n—¥oÉ¿¢Ùv0µ\"ŠêG•Ïupä×§>î\\€yqT‡Ë…¤ŠÀ?lëË~Q¸iv+Ò6;’Ù¦u\ZÒŒÒðq”‡È<ÓhÙZ¤tòÏ¤dòAè!?0·¢Å©Ì¸éRáT>zîÑv1ÕÞG¥„e_§\nRÂ¨.+Ê‘r°$=•/G*4G¥PÎ>¨Ì—¸\"‹Ç¦üÛ»ìÍf:÷cyâÔ\0Ò5¸ µ²«–ŒÍ\'sbKY\"|²‹ÎôeR•:MäleÐß¢“XëëÍÔ½*Y8ªÄÌé½B8•ëP	^›22@H:æc…4Pt64Ü‚Gx§÷§\'yX€\"G^^gœõ¸:Îk£º«j^¿fáGÐ´­=qËèMŽ$hˆ´GHM\n6§ºòÄ`2LÄqL;œÂ§ù+	ŠRí\Z\"³Wˆ²«\\’ÛXÔa´qóïT›ê€ß–fÑñó=¥ÚçÿÄ\0(\0\0\0\0\0\0\0\0\0 !01A@\"2QqBÿÚ\0\0ø7•£‡Ø½–ÄþUæÚ-ç©šH²Ñ«õ{ìOäêG?6Zø–’5þ¿½¾;–ÍLÔ‹]ÝHÔý[{m/2Æûøë¿]lC«3«Š,wícÁš¢öYe÷,¶[/m–Yo~&*	¶ÿ\0-ÜÌ<F<©•ÉÆ\\çãÎ|nvrrS(Òi4²—ºEE•‹‰Š—ía­xŠ%5—>½–^Î}ÑÊ9ðz£Éý9õpgG¿»‹ã›$Òòš÷q5Pæ\ZŽ$«ß6*ºÃíýoQ¥TM<š=ºà£JLÓÎTQQ\Z*ENÊ‘÷š±\r-»&Þ’rÄ‚óøÄƒô7$-rDµGò„®Cêj0ñ1[§/Ám­ÿ\0Oª7§S:“5È×#\\…&k±\ZóÔ/íb¡âGÓÄø:¨ê#¨Ž¡Ôbf&+–¥9ÕMa·áÂ^DðÇ+Òâºtú0ò£¢-±ÃD[[Y{hQB>ÄÅWÅ\"ŠïÃ\Z¤Ñ+±ø#ùÒkœ¢þÑ6¢«ÑQ#ùÿ\0(é)7¥ý>2çeg¥³OL£Œ“’eÄ³RMç|m|»Ú£&Fzb<^8ñR9~4¶´‹×é9ÄêaHœ%ËêAxxÑ&­·•\ZMÐý+ðÞ¶øQ{Z(¢Š]íx~ºŸ®¬½<LBÙÔÅ5Iùß.xÍ\nTkf³Yªf¯ØžJŸ[ãùPÕ:çyA“ò\"|˜Š˜˜²\\<´~´2ŸÀ´YÉH¤R)²Oc (BíÏ‘~ˆ¬5É‹4Ä²Y¢Î(Üþöl±¾’Î™È‘¥\ZY£5’ÊË,áŽ%>Õ#íÜÙ\'o5Y¤$tµ;:(ÒQ(ÖK%²ËÍ®Õ—÷ƒ‚²c{J²×G]‹‘Æ£/¬£à_·YYcëE²z’-‹©.#_j‰<–k*ÏYÞU¹é“¨ô§”c­ñ(éeç{ÆF2ŸJ0B”8$tGÄ±85rO?BÎ&›\Zqc]¾\n)Œ¼žæ<ðþšSæsÅÃÁZp­·lÔÍR?¶_\'¢¶P–L’¦<ÖTý,c¡‰þºNö>3¼ÑCTSn–0þìLo¨”¸e–j-ŠÈÄY$#Yù$¬j²ð!8šú uàâõ<L\ZûúŸFI4èÔÔ4¿{–è5Tç)ù¡¢&@Òi+j,¼Ù%cò1‰ç©Ú£D98I²mÉó—¬—nŠ(®Õçyâ¯y{KÉH£I=	q›ùV&[d¸à¼¼’Ž’^v.Ç¾ãy\"Ë/>-[«u•—–©E§2ÄË19²^2Y/#Éçy//{ì^VYyYeò,R†ìOÌÀ³õ›Í-RH{,²÷^V:ÿ\0%–Ye—ºO’Ë5‘ï8Œ[“ä½ÖYe—•ä¾âË,²Ë/:(£@áÉÓF„RÚ¾\rçyY	è•žör(šM%Vms›D—À¢»šY¡šŠÝCÏÐ×–~Ï<ãkÎ·ÑEi4Š%WfÇ±’~û)lõÝöyeœï{Y=‹ázbøÎw“\'ãb{Òø>;oÎÊegGèDéÉº=•—¡mõÜc\"“<=¶Ëe&iGÿÄ\0\"\0\0\0\0\0\0\0\0\0 !A10QaÿÚ\0\0ü`‹ÁDðFE¢LH¿A,‡¬˜­*x£zÑ‡áK%œÚ•“(Q­NfHÍ.¥dH™$±Kàà˜F}&‰_)/š×Zø<D¨bT˜ÒaK=HÂ“\nO]\'®‘ÓGlR4Û2ò(B©£!±”©f6CÓƒÖ…M$\"4VvžF¬¼‹¹_Œ#‘ZIš?ÁR1»ªª_i©=fì˜2Ö\'“\Z†š)lz\"šúzd»M-×‘·Ç±ßÞ´‘\r¾¯ðm¾WLCp$êåÂ hw›\"S\Z‡+?§²¾¦±È„=!}$U}2Vv‚,˜þÕâËHº¼jÕ BKÕ\",µ‚ÒŠúb4.\Zv\"B ÇùdD‰FFB³ ‹Eò%tdI(ÈÉÞÉ”¹ kóC²ÕÚ›;+7¤“¢ÙŽ£*ebò>åÿÄ\0\"\0\0\0\0\0\0\0\0\0! 1AQ0aÿÚ\0\0²ÿ\0†ÂyØ¼Yy¼Z,²ËËi~7xà¿ÆÆÅ¬pYe›L·÷^-áümœ–Í…ŠVQE»Çù˜«f¢‹)”Ê55\ZÄœPîøÖNJE~´ï_²Þk*?SßÑsCœŽäŽìÅÔ‘Ü‘Ü‘Ü™Üd~ÐÝ•úëê”RƒEQB&ë“¸nŸÐß–ò6“6c“ÇCô„\"†±VK¤×ªx¿Å²Ë*Ê#£*…*ÆØCx—MKÔ¡(‹Å«Â44X–P¡·ù8Ð‡„U“é}^\Z¿1BBIx<(\'Ã]Ù(¥ÄÄËðGW§êIãYŒ\\øÑizRV‡Õ-¼¬¸÷Ã—N\nû]\"^^Z55+›/LšÙYÉÏƒÍÿ\0-xQ5L¿+Êð²Ñe—…!	“VË,´Ye—eð/eþñF¦¥ÄÎCbEQLÔQ5)…à×Ô¬O	æ¼Wƒååø!–_¡(P4C„yL£ÿÄ\0*\0\0\0\0\0\0\0\0\0\0!1@A 0PQaq\"‘2`pÿÚ\0\0	?þ~÷°˜ÄXy7‘»áa”S{¬c’–:¾%7þ‹lEgr:É[¸©ÜôÆ?U!¡B¾\r®ò÷Åù+¹YýKÜ˜Í‘CR\nÊžZàåe$ä¤î´üÓ‹aÜ{×ªTo¼«:Î%}\ržÕ6;ŽÐ¤¿§Ê¸šþVl~8ê¢ÉkƒµÆtÜº_\"òWo}Ù‹ËGú8£hÚìBû›E–ö³BPeHˆŸ:¤éÙfÜžCB„cÍ[èøäÔžZŠ\"ãKÈÓñÅU1’{§\nÐ˜æ!(‡œŽ%–a	× …ìcQxËWÅÇT}e1à{—NIï€ÆßwÈ%²ÔºÑï;—ï¹§ëzæ´åª«TkýÙóÿÄ\0(\0\0\0\0\0\0\0!1AQaq‘ ¡±ÑÁáðñ0ÿÚ\0\0?!$gMˆ£ñ¢ú|Iï;Äð}VJƒªöK\'Œ’ÄŽÉ3FÙ<h–—ôo¤ñ¢ë$—ôÙ\ZyÒ–‰V^Ãv~4O4:-ÐÍñ{Ñ$²IÒy,~ó­~ßGƒ%ˆW²Yd/=ŽhhÂ}ýiZx<Ð‰gƒcÁãIbhŸì’d”Hžgê®ÒçYd±tKÕØ|\rž6÷7¥Ÿå¥–Yb±Öˆ|áø(‘#[š«[×üõ\'F‘»Ò7×a¡,’ •×({b9i‹cBûã@±U³ùÒ‰9l+#‚7ùÒö!ë$’}ÂÒ~’ËÆHrGc¯½c”7Áæ=oÙø\'í¦tD³Àò\'ÌµYì‡±°þDï”nP•é=²ZÈžÈŽ‰ÀÌds‹sE9!²ÖÄŒ¢zœæ	†[\"\\ßƒ’¸”\"›ˆ˜Í<È“±N\ZVåç<é:^çv7t?Ø2?Q9ÚÌ÷2^KÝ‹UÁ	b§a\'4”»\r&Ôå‚6‘9:”ÞÈŠäÅû¼hGÙœ»Ákg‚¶j8!¢˜!)÷A4…Mó¦§\ZmfÔQïxÃ¨ÙÝû2áå–Ásmé\\¬N{#²ng&&®|*fùÙSÆóz4e	ò}Ê$”‡b¿²xÃÅ¯ó‘©¦åÃÝUwËÝ	ò%Â$öùåÓÙ\0ç×è^Ð¼Pƒ‡È%BÊSú±àäÝ(¢j‘Ï“&Ä²IÁ¦©6Óp¸Šatx(HÚ|2žèŽ–\"—ú‹„ž&D±,!G¡%iÕÍ6CŒŽ×¼T,d!Ð‹AoÞ¨y-b;	ðL­“;sììû‰ÍäãbèD»XÝ¨\nX¶ÄD™ùØ×IªÖÃbˆù\n+Lm‰N¾åqé±Þ1R‘nÉØÌÖ‹{ú)pðÀ´!lƒ\'gšÁ“L}(	¦ã\'°¢ûL(á+ƒx¹f½î4Å-ŒÓ¡Hlx‘BvÄ2EVÆipÏ²lwI=…/£½´áë¹Kuqaj\Z\"öPÍ½JO¸¨§Å¬j\"c=â¥oý\r*’éyfaÛ1È×°{ž¡m$¿Þ®D^1/°öÔ%J‘D¶0ÅÈy-y7/${¢AŽ‰\\¹•a\"y}VS\ZVËS?:ÊMUÏ$Žq“0\'¡_,§-”Ê\\Û“½w$†ñ]?ÑGTÍ![~‚pþ\"^>Ñ²’Õl1o`ÂÃÆ,R[,‹R÷##ØH•¯%aG	÷£µ(VŠfÈh†„\"__}Ù:0}pžÉìx+aÿ\0 ç¶8$™\'–lÆãžpsø„O¡«Ï£¢¾t\'èÊ“zLm¸ÔW¯¢ˆ4l2o*põzÙd“Á[äÏ;û³Êu¥tG½+b´À‚y/G\n+j=„ˆ5p,`¬v^ÑÑµÀïD¦OAÚïà2iØl¿>uIô­gŠ1x!þIìCeÍ&ó±³ËrãJ üŒ„GPáG¦E)çco3>‹!	±Ê~ˆÓ¢5òŒéì˜\'I\\h¢øö}ˆîÅ%¿Y!p*Q\Z‚ÓRÒü\n&6!’ˆUD;Ì‰ÄÙ6‡ëØp±‘}îbvY¦\rËî(°?ƒWzXÍô½oC~Q\rr9Ùí¢ ‚8#¯:!ZÉüÁ1)\n—ò=–™pÄVÄiŽ[T4à•$|r,xLS}xdîXV&tÝ“Ø»zV²É,—èÂ™÷¯Á’YÓ$jcÍ\rˆhÉü›ßrGDi²!ä:~	»27è„‹>NŒ{ÆH˜š\Z•%à²Í´›‚ÅŽo“ìcÙæK›‰y~Šc/\'Ø6ä£#Üy¡âŽç\'uX—¯@‚¾áÝO”;‹”VbÏWètüô/\"OÜL„Ž68I¿àdŠml\\þF:›P¦Æ@É)cí@:Ù¼1»?\"N‘Ú?èyÏ–dñ¡ßg6äÌbI®\'<?u	1Èóxuˆd^8É÷ÉŒJ sÉ×Á0>DÆOü6&\nù#CMÅè!º±ö9JŽƒb‡û,¦Ž‡ý‡P†~¯vF$úöGpL^—–ÄQ#!r\"àˆþ–˜EÀ©ä‘Äö\'MÑ1Â6ß#Ô}fXªÁ¼@ò^âSë(lì™ƒQìtT*[Iù\rÜ!s	\"\nãhù@;yyœè³Ô”FÈÉ-\\i¼€·|…l,’°¡aìÅu¹—ä§ìgºGÌäššWý‚x×ÒIoÇØëü£˜âÚJÝfmctÇmÉ’˜\"_pñ‚ŠI<0»´X7þ„ûÐ”KØUè‚Ë\n•ì¶1²%¦M–#PX¦VNgØaobV~Iyß+†?\rv%Âå—É³àWàaâ„(CÁ±¸Ë?àŽ=\"$D-…/‚‚´ã¢E´O‘º•W³g´|Û½„âÈ«Zx‡ÏA Dùô™¤R(¿‡š6<`Y&ŸØ½ÎõODCSö…Ð•Éä…¤÷ôHY$Ô‰:Þ¶*‰’±›<x(t_æ4hádm`ÇŒy<Šú\"I‚O\Z=S“\"%eèÜàZ$½ÆÛð¹2h_™rK$zU»&	%z0ÜZT¥RØ\'êeNèdÑ°Ðäd™(fÅ\nÝöOÙ€ç?\"µÙ’2D$N‡‚f´\\Œ¶QÀ–ãÒQ\"vIåd­Èz{	h‡ì{vÏÄ³5¢µ…º¶\\ëìØÜhêøè£}†ŸÑÏ&Zœ±ïÅ#dŠÂÐ‘“ý’‘(ü“]!§f×|“ô×£¨Ù,’|eN#saS†øÉ½ú:qFEQ¤ÐÉ$¾E¡ÛD$ž=èšð1”Ó7Œim’Ü¶!²DË‚ã$¿‘£añµ[\r´äÞN†˜îÑ/rô¿è}äeO·°ØÚÑ,\"hÜÉz#p1Ê6Û7ºI$›,Æ<ˆÁDBD-d_\"žÃMì\\|hØœBuÁ±,ÎÃÿ\0…î>ÿ\0toD)ì’¹ ‚Ë<k~ÄÔ LßgQˆÄ¸’ GAa³cZÕ¢?±1LI“l›4ayÕ˜¢¥‰Á‚— ®J~Âæ!˜„)‰6ÜK¿ÉZ5vAD „•Z@‚lQ‹=6^zb(n†ÍŽÇƒüô#û?jÂÁE£ðGÈÑ		bJNKHó\r¶7–W$·ì¸×b ÜkÈ›ÜY24-‹ÉàQ¸¯âù3ükZ$gC†ç\Z~O•É±Ø‚\'ú0»ø1£zOÆ“Æ’nIÃ…§à‘	at$Œ*ÔpÆ‡D$\Zny1§cð@´½½‹²tYÀø\r’õez7¡nÅ3@ÿ\0ÏTåc^JFÎ97Ž¢²›CD1¤43bÃÓmwÑ`ÀÁŸ\rðz&LAëTmªÀ­“c/%(ÊJV‡&Ìà—:B<§ÿÄ\0&\0\0\0\0\0\0!1AQaq‘±¡ÁÑáðñÿÚ\0\0?»kŽŠÑÂ²ðÝ¨…ÆåY²RSpGbmÌ^ññQgXe­{©eî8íî7t40Æ-Ö&,LíèË.³ïâ[uûŸ0½~&y™LµÍËUT²„­Ì„ÁÂ–‚î)…›Ån9´9¨<é™1	ýÅÑø{)\\o©EZLéüÄ8X1s*k\rjf^è!-Ö/†X\rõ\Zh¾ã|‚ù¶ÉOL¦ ¼]N†;–9Ì0Ýçˆ\"Rû‚i«î	”ãi›1g,Î\02%ššàjXfŒñ÷¾\"”)À««¹c±ÂÅVÐÁbïõÅ»E.rÅ×]oãü‡ug^2éÔ8Œñ6­lˆ¹fLâåòË²,Ö¡ÌÌ^Ëz4î·.JÃp3Ü»«ËE@ì«æQÃˆå¦¾£Šv‚	T9ÇIÄÓˆ9)É˜Dqõ681`\0g¿êaÞãÜ]h<Îo!§¹p½gqR¯Ô8¥øË´\r\\Ú[Ëå–^^õVÜœõ9”[Ë‰mâÌ¡å­BÅå”–ØO›éšbªgŸünó/¼õ/––\\o3ƒMË³£Zz‚Ø¼ñ}xâQ„&ð›iò ©oÅpFâK	ys…ŠEcyL[ýE³8\r¥ÙƒãØÐv²ói©êêX(¼èz]0¨.¥™HÝÛ]zõ\Zº0f¸ÖÈy—vÌn·R×UˆÚØ‹|ÆÂŒ©j‡’€…1‚3˜î³f¡U\"{ÁIå,W%õ9Ï—>iësÂ[ÃUˆjX¶ü,¡`ýË¿Ñ)ËTÕA«T\'2©œL¥/ÌU_jÄWÁßr÷æâ¼®pEh1ß1[(qÊà¸± –¨¥é©zlA™&D®6ý™¦žæ`-ÞŒ/æÚeYÆ™fp:¯òZšXÙìgìâ<òŠ\n\'‰›óÙi­¼æt€’×E¼Ë¯ˆž÷¾?ßãßÌ½ºN~|…W1o\nÒ³>6dgn¥xãQ«Dºn¼g#. b<‚.Ú›ÄJ¬Øå–36`uÜÎþkî~]ÇðêÑúØúšý&š¨ýìÏÙ]Ü£	qì‹êRVup¦6ðëâ]€Û„þà…TÊTÁ£\"U6:¨ã)—KÄèÔi^\rÇº.ö2êíÀòwC‹…Ø@œÂWæ7\n=*WÈÐAQ>\'@¹ˆ¹TÊûEãw‹UýBÆ÷©wZ²ÛýK«45½ÄÇ\n«ö½¸`V)læ	c;¼•Ð†+›òQŠ—¤Í\0bÞ~!ˆLãý±Óy‚bã\npÍƒFM’öÙ6îáÖæ8Ïâ\noq/“]Kµm/WGâ³™^´ØKÃ ní|­ÄTúæ¥aƒ”òàôAÔˆUUÞ-zƒà\'…æRŸèÆ6 Ðz2À‹\ZU\\hR$9‚YÉÂvÀ•é\\>Kw´Ò±öYn˜\ZòKÕSÑHs_;è‚†{<”î\'®½”ã!¸GB¸±> K›Ðñßç11–U;‡‡®\0ì 7+Ltc »è±¨|ŽàY¾ t|-ÍÊ¤Ðcþ\"cpìrðà˜’¶—–«®.R!FïÁên&©…ÌK_Ï5m’êåŠ<Ê¢ŽgÂ¾qhÝâ[¦ôÃðbc’û›U2Žâ+”¢ºDhØ*Ôµ-þÍ:]‘T¤+ä¨+•Z-Ÿ$ƒÞòÅQpmýn±4 æáÃR³Ç8+@9ŽV,·kÒÈ \n”—Uÿ\0Þ°á»YŽ5€Ï¢”æ‰…	7f\" %\ropÙí–\\Ê>{·‰\\ïì¶ÊÞ4ÆÁ¥W+ë/Ë¬i]Y+ã7aùÖº*”oA²Ö€ã¢*Õ ]¾ˆíZ¤š¾!=à^˜€´ÓwŒa…,Ö9ÕŸZIQ¬b)µZow-·<GÙ,Þz\"^¸ØÁbK*XW2ßë§ßßÜ—‹âÂ+Ð7µ²e)„ˆÏÌZ\0oâ8U\0	}éÖßMñ,9#uåL4t`b1<ßGÈ±¤Kò¯ºªûƒ&W¹H\"·›=ÔÆ“Fïõ4Íßq@–-D®/©krï?Áè—µÒ¸¦QUm-±-n“µÃ\ZÑßïðƒ²:q‹¢åÆ“àâ^¶bFÈ™PÉÄ·;ØÆ2Ô\0]{X›=Á»Xî×|ÝœP[]BÊ»*½ö)ù#Ã–4°2;—„õ)Ÿ`‡\nÍËŽn.unp á‹äS‹„GÐ#EëÆ\nù©k(¼y‚µ„Æ;‰8ÂÀ¸ÖpŸ­\nqÌÃÿ\0&RØµß3ŒDØb(ÖÉžC¡›¦Dâae#ÉÓ³$»5W¨/RÙq²ÕA˜Ñt0¦¡SBÖ`êe¿SÚ4œÀ…b›ù\"Ùã 9f[`ªÅÊÀ«=gª–º[§Ì¨îÍºãÐ0ñƒ]DŠƒM»ÄÏq•põŠªÓ˜—t$ÓÃ}Üi,rB Áä¬ñP*c¹õ+óy3O^Œ´hˆ+4ò69æî\0ºÂË›\rÚªbÖlmÃŠÉÄpRå0[üÞ&\r<ö%«í³V°Å¶ç¨ÕvK-vpD’.,·F Â,ÐŽüâ;Çþ%«dÐŽ3¨fDAF™Š0î¼\\eR\0fÃœ™—oÃe»‚ÉZY\ngÌÄKœÜIÜ°åæ6ÐÊ£ø.¥¿mJóÔ¶]¸Q*p\'é]´ApU»\në}Á¥E†+³ÔR–°âá\"Ñr0¬äˆÈˆÖÈ×£¦t`+–ý.\ZÕK˜¥Ð·Ì&L‘ä—bù•à_™Dsˆ;›æÉF:å—pWî9\0ú‰ó	EâŒZÁLñÿ\0™3û‚ß®¾&tqÜÃ ÜüÇ„*[ÖVåÎó@æ‡pÒ¾ “mm)(ªüE«Ù){¬Yj°(Çâ	yÚo\'¯$¤Â\\®«=Ç×S14^zcè¤\ZK®à–…-¬)Rt«¥/„³’‡ŒQ`Ð!&DûBî06A8–;n¦^Y‰Ç£†µ¯Ô9\0\n=1Çæ|ýÇ;·ªœä_f9¿	éo‡ü…>àýkO‹¨µkÔdÇ¤Æ¿™Bæâ¿í\'\\œÃ£‡DÏ%WRÐ^	c{q(bZÐp@+¡œzÿ\0R†î±­Ð«ÇrµMS©œWÝûAãžæÒvÆ\rk\ZŒ,ZÁPC“.¿ì¶÷jã¢ddMéN`×Ô_WÂQ±\0xc`,348s…¨Mšb*¡ÀÆèÁÜW[ö\Z3jÃMÛ ¹DüÜ²‹&2?RÆ¦ž7?ú¥o=Äj•î\ZS\'ê)\0/sFœêYª§\nñ)V#®Þ’þ‰—ÝJ˜—²àÃŠjºœÅ .Ñ®¡Ø-œÅ(5V&§Žòó+²]´Ûuîò·ä]ŸÌ„S@Ê¡­é€±«Š+[jüÅÁ¤ë¨WM;©W0áâCÉ½-Xãb\nsTæ¯P…r7rÛÍ	làüÃ¢Ð¦¹\"}±Ã721SFÈµ”:Ž†F\\´³-‚Kt_p®7ßþ\0È!]\0zÄÚ–æLæî,–/”·5Ô¬LS­‚4U×ÈÐä¹±•èHÝv÷˜xêNÈìÀ°ge™š]iak¾caº«ZŒ,zB¡Cš”FÜOl¾Ä¨//„ïšÊK¡_p\0@Ò8ÜLYú, È`¾b—™È8€Æ0Ë¦PªÜ$ñ§Ÿf«¥62ÂsY‚ÛlbRÍà…¹é™½Ü5F=•Ø‚\\9é˜Wgî\\QL]‹ÓàqzV8.S ÎØ¾|î‚rvÇ•RÍ|ÌKò™BÕá¾}… sÌ	AyfÝA%H¾AK—	µêâåÈ³ÔzØÎ\\	Ž¦ÙÌ7mT²âÇ1¢`ß^@QY³kÐÁýÌEŠ*Í¬ rÿ\0SªÛÕÆ”L×Õ;8ˆÒPOÌlf-¥ƒNžâÑ¡¸Uq˜Ù’™~àÓb;ñŠ[hcg”‰x8™ÛœÂÔqP$5sB`ñs~{WedûŠ¢éö4ès*ÞÆ1*’VÖþ•½ÒGÑ”E¦Ì0d¬æ}D@q)¶ãˆ%äó/´íªÞ¼gk‘YiIwÏÄ^êƒm[íäV×p;Ãp`j±uÎàp	ƒR–Ì\\uØç˜mü¢|Ü1ÓÍÁIÚ©œ“øÖãÃ|™¢-Ž•äiC;ý“\"šW&T%1Z¿`ó<}‹ÚšÁã/§´q!KÈÐÒŽ=î€«Ïˆ-rBr‰6döJc‚ñf[ÉÔø$Š‚ý‚]<UÄ8–_IáYU\\c2Ü7œðƒ!iÌËé	C£Ä)ì´•0ùáÍ°AÐ²Z‡° õ,ºãqå«2G8…¯\Zê^ç¾ûÝÌ«›ÂžŠ™Õ\\CAí›”‹~|4ßÛPV.m)þ˜P‡*Æ1çªÐü<³>îË£ÖP¯=r•JNPgb(½6	PÀà¹šBû`65{J`,}p8nñÉu‰®qâ³Ôy.XÖöQŒo•1„s°ÂÑ¬Y°åŽU×?1Jk~Ï·‘PórÎáò(-ôÇmR©›ÆØÎËæaá†èGµ\\t}ÄY~?ú¥ïL²^ëˆ7˜ÑÊëÆvÖ…KAEP:ó\"QÄ\"Õ0•¶\"–3ýÇXÅ<„N%Ê9õÔÊ¯GQ½¼@¾aoù0[º]ÈQ„oBÉFû_ wZUÀ¹ØŽ)mø[`çú…Aj\'3ˆmº`áº±%\nhŠap0ÌNî	ÁŽ è…=y4Ö¹!žnåñr.áùyÁ/*5Ó“ü YWW~ÄÙ•]EšÑÃO8˜Lg¨)©T-‹ÐY–$\nÝùÀtï\n~Ú”kMY§Ó(\"á´saäÌ´%tæR²×pKx¬¨«íÇ.ÀÉ.íè•@£”¿™ÚõaƒñæâÅô0ŽGP–K\0wìµè(t|ã€Ê¬ïØBë™L¬¬3Lº­öžBÊf5Y2Ð _\næžâ,g´uÐå¨³\ràŒXMãôDø½üÅ˜ s6‡ÄåÉ9YY©gÓP²\\[ÿ\0âµ©u‚¿ÍŠ³¸Í«µ`õ\ZÕ¶œ5`ÇÒ–½pªÂ2ZuÈrÚ+¼ß1W½‘o&\0Tg$/K\r4LqÔ]?\nW$.-fu-êVüäg¤¸rqìE©®ˆ¤Ýñá1;wÚ;¢^´^5«¥Æ (¢ùa­Ué€»ÕbÈ¨ÍÖúî-U=³0M_ágáï2”/n&ƒIG†F-˜LðP´·Ö!èuÜ¹ÀàCw\'ð…×üqƒ<™Ð!ÁQjt<Ëu\\¥ÕoÊh»£wñØÕÙ0¦Ñ©ÁnY¦ë¤î2Âï†è8n˜Óãg‘Æ˜>ƒd¥J«aB–ïK™»¯)€.y€‚@h[ÝÃØB°Â±¨Öe†r¿Ä1]»ˆºÌ¸ý¤é˜ÐeÙPpèÃ‰ŽVK›úÕŠfcuËÉ½÷4¼zŠc `L+±jVYƒ7ÃÑ!£‚}EC‘Cá‚ ÈÚ_¤´å`?n(eÉÌ6‹ÉÕJ¼­DTnê~®áŠ:!Ôã{ÜªN¢þÌö4tìö#góæó6`0JVvÄXeÄƒ£‚«Ü„\r*¥V¥Rí}L¯lÎ•écFŠqžO\"–¦î/<uŽú‹§ôÀºç™Nå…+|9#0|^Fi¥rÁp/y—™qCÈÆV¿HBGB„…Uu˜ñ“.„Cškrëbû–MŠKM±\0\\”Ìæç6×”ö+âZ‹vä&Q”Zˆ£\Z—(!{{‹UÄÆiÉ¹gÍN¥š|‰F‚a”¼rŸìKôÃ2>ff[ø<Ü[Òl ØáÉ…ÁþXÔX…6¾ªEüJŸÜ»Æ¦4#n.ZØ*%¯VÃwp¾ûÌNZx	¢ÜòÌAæ+È¬\'2ÂÚ˜Ó*\r]a—B³Ð@MÑˆ;”dÜò?3w|õ*†öƒyzNA¶ìˆV—q—ç3}D%ŽfVæ`¶×1.ÝñÑ“•–\"œê\'Å~â\0(½Á¶Å\0DòQ)¡ËäQpóØV‡î9±Ì¶Œ¿RŠÍÜ¹â|¯&4Æ…»}íâ4e¥*j÷ø˜P–s3Í×8àê°ÑÃJy(ÃÒARq±x0q+8ØrTÚ\\ÈÛ=Vº©¬ª/0)Ô2Ó#dA»ŠŠÏÙé/yÒ#ÓÄ°9«Ñ2,õÖkî[ƒ_ÏXˆÚÄe=ÆµNy&Gfòz@àªö!¬„XSó-EñC›ÁäÅÒ¹Jï‡~€++bïD/· ø†¨ÆžÓ˜íª}öÓ\"Ð\\LšRÜŠ.ÈQœËìâÚ&AÆ\Z¾á”¹¾wP7]Ô¤ü%ûºì€]jD<y¬%99èŠÕ %ú  rº%®¦=Û²W¨Ž~Q…®ËÁ³ô“2¹…váš¯(÷ŸbLk‰­ñÇÌØ½»+È5W’f9ÛLy^`@¦¥i9ýˆú‹¶Ká0Æ×K¸ºsƒ7ýä\0fpx7Û4›f¥ŽHÅFúì– +ñƒñ¹²ÚÄ\Z\no›…Dm0eiªE2¨Ñ4š_,-\r‰\0ðÜVš	ˆ¥ÚóüEìŽ¡\Z/ÆVZ—Ú-æ‡8îÁO¢G;†­\0$(ÒÔI‘¼ÿ\0¤ÉÌ±{¾9‹¦Ïw.í­T¤2=Ä«ÅÂ£	\\Ï“Û…ñÌûs’Ï;Œ¨Ý-U{—?«õý„èêlä¹a»üK˜ÓÅ²ª6PëÀéÔJ\Zñ|†uc¾`1€òE|Ë©N7ƒ÷\nŒ]62…óÆuUq%·­FPhÏ2œ-ý\\U“yÂã“0¾¥+,´&^Ùÿ\0ÕÀ6ÀÛk]§Ùì¥òLT»¼/ò*vº‰KuS*™î\0‰Õ2˜9‡<pŠt9Öbð¾ª.ï™j·É®·¾á`¬×ÿ\0f[ââ£AžfkYâgŒ¼:¨éžËÜ\0-t%µs±\0æÈ£‹\r5…WF^HSâli×0Ê°9 r³×°[€¯at¾3û›+Á&pµQP/<À Äÿ\0ê‰E¾}ÉtþRÐÞµ3W¼ÕLÕ`é‚^S˜Ú¦Î*¤nf?ÂDo¹[Â&†ç/d:þâ×%8`âTnk˜}T*z;ÜF9%%Ö3† ƒ.»D9#\\ÚpJþq˜x\0Nboûö{ÈêÀu|ËAqG¸ê“\Z¿Z‰Dïˆ÷qó)\\_Se6_y†ÊêWÞÒé2.çóýJãòÔøLõ,)âoj¨Ë»d…QÃÚŠïSçƒò%9á(åæ£¾y˜ 2©¾e*ú˜XÔjÎ¤Ãƒ:€²JQhõ”±Û3â\n”+‚§‡P\"«lz¾ÙŒˆhø–I§Sæ(Zšy‰¼ýL8J¨Ú¶Ê[ìö‹’%SÄYÁ×ÔW|çS8ŒÅ{ÄZ¤»²ÎD«s{B´wÔµ+“$e\r5W*;.jª8Îù!Ÿ*6º/¸¼œ0Õ}@¥`—Œ†eµ¼?¨…f<Dpâ’(Qòei\ZEqÄAJRc1*À¶\rV½wT™áýEÃmžK<4@iìj½{U®¶ˆ´å‚Núð[’QWfq›¿î9š¢üF–…Ü4Œ‚Ø#¦d3”Ëmz­ÃÏ>u²³t3^äeëjàÍBlçs1Áš…G*æÏ=y¾vÛáë‰Bï.âQAs¦³(xÄAWŽ•â=	l\noqéžÈli#º2˜™áQ·‘B~ [ˆêÈ+©R*í¥à¹“+·\Z¿ÉÆ˜ŽÇÈQGê.¸Ü[d¡×2ÔZŽ¥ƒU`­Îê³øƒ\0x¿Ä±„Þ)ú˜£?[qž‚]Ó6&}#—«ô/ªC»æ	R¸ÌøcÌŒ÷¹•½`Ž\ZlÙ¼0±F!‘(à!š¸-Ž£‚Žs,µÝD»N„BÇy\Záçp1|þ“Cú‰aÜ³hQŽ%ó-[z‚ÔÛês‡RíÏ$óQ9 ¸%Ý˜ßÄ?‚cF lj ‚1ØËlÖe¿bØ–mºq\"Ãšœn71ÿÄ\0%\0\0\0\0\0\0\0\0\0\0\0\00 !1@P‘AQpáðÿÚ\0	?\0ÕÂˆO»åb&Eö„åÀéÌVa ðÓª+nAQ¢¬Í\\øv(¢·ÃÿÄ\0\"\0\0\0\0\0\0\0\0\0\0\0 !01@P`‘ðÿÚ\0	?\0ï±kðénÈ˜˜…YgAÞÊEGE(5Ä4rLkJîÙ‘kF-U…n;•cFcÝìå§ÜñÓ÷9ÑùòÀºm§ÀÔÿ\0ÿÙ','2022-01-12','fief fef saaaas');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ideaoverflow'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-13 18:27:28
