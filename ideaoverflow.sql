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
INSERT INTO `follower` VALUES (2,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,1,'2022-01-11','Falafeldöner','<p>Lecker!!!</p><p><br></p><iframe class=\"ql-video\" frameborder=\"0\" allowfullscreen=\"true\" src=\"https://www.youtube.com/embed/1bZCwrevP-M?showinfo=0\"></iframe><p><br></p><p><a href=\"https://www.wir-essen-gesund.de/falafel-doener/\" rel=\"noopener noreferrer\" target=\"_blank\">https://www.wir-essen-gesund.de/falafel-doener/</a></p><p><br></p>');
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'hiebeler.daniel@gmail.com','daniebeler','$2b$04$H.qrdjSQ0pP0EBhd2aJsuOmr0Ef0uQ6E2qU0ZlpaF2tNVyKzVPiSK','',1,'Daniel','Hiebeler','https://daniebeler.com','daniebeler','daniebeler','daniebeler',0,'Austria','Vorarlberg','daniebeler','daniebeler','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0��g-\0\0 \0IDATx��}	�eEu�W����_�4�\rM3�325��N8Dg����\'&j�fi�cg�D�<��\'PQQTD���F�f覛��o�����s��w�:��Z��{ϩa��_�k6l�\r��#B`�w�3��qu<�N��߽^/}��:n��t:Cy1}~�C~&�������4��.�����K��g._�A�m�(�7�۹s\'��k/<�y��-�܂���O񬴒?���.��:�N#C�˴�L]G]�U~�qG�z�<�Q^��s�Y�k��\0�S�ãG����#˵xSzg�K�I�z��r��m��U\'���{~~��_��أ)Ƹ�CZ������ni�R�6�-fY��\0���Ӕ�Q�B�=:�m�i�yY��\0��yy���1[����N��4��1�I-	�4��ҙMu�����ܕ�lC[��|�!�@���$Ò��YF[Y��aǍ�ܔ��[�%Z�=?K�nP�|M��dfsV9uJ`h�i�Y\Z�����U��`��ZS����B�4�Ig�Q2Q^y�%�L�ZM�B�kM��O-�f�DM�~���R�^}�����FP��Ϛ�q:^fm\n/e\\J��T���Ғ�mЦ��\Z�G�`������1��͍���\ZF���;k|-Y��[��Ӭ2M�I�zB��{��L��ӕЎq�L���JV��/ķ)1�D��tV|\nyjj*}.Z��n�t)t����?��{y[y�2Z�����TY8-D�`V�U���Z.�hŵh��Y�?�-�l�^�an۶\r+W���\'��>��^LOO��p��âG�����:N���hӺR\"Z��o� M����jj��\ZU�ģ���uc)��cg����nݚ��g��#�<W]u.����,��\Z���WKtu�\0��B�3T�Y�?~�L�&��@\rQҰM���_Z>��ϵպMu,��4|4���~:?�p��W�¹瞛��%KL��5΅4`M�t�4~�����-1���[��S�M��`�8��iF��2�ն3�j\0�phv\'\'\'q�i�%�����w^��sB�Ϫ��6�֢�\nA\rs5���g�܆���m��P��x��E���i��J���N�BC[m�g�M]6�g�y&�:�(\\y�8�s0;;�=��c�>=����\Z��F$��A��=���%�̨%�R���l�ky>��nyҧj�{�~O[�Fk�R(i�lv3�=��>�]���kh�^+�\'#˗��������\r�㙥E�\n�A�yy��$������ֲ�˷V���<��jH?�.;���8�����W�������Ƭ���(�RG����#�|jSv�M���9���6	��z(��t��aI�5�|�&����=�܃��	�u�Y��^q�C�����eS2�V�<�����)�E�U_�/�	���j�!��U*_A���CcNRӨ�{`�� �{ZU�ݣ�>:��/}�KC>����U���Jt�<�l�o�}�6��B�O�9o\nM--��r�4�WA�4J�X�H!zyZ´\0i��i)<*g�q��������a���x�Ʀ�B5��:�&?8�Qk�Eg�J����������=�Yi���V|O�{�@���<c7�V��2���\'�\n�9�yN��8Ηͮ�|V���L4]ȹܦFe����\Z/P�Wj %7��3���-P ��5��s�\r%�g�I�	�{6!�fA���z�8k�m�}���٥��q�\r6$ͧ�\'�b���&���-*ű���b@�Ւq�JTF�`������Nص\ra�b��>Wρ��C��S����q5}�~l�<�	����#��q��\"���~��I��@�T��w_��޽;���}n�|ߗ�����Z�?����q��m|3χ�@���Z�͢_�<w&DG�ZB <�<�����D\\���#ǖV�R�\\�넄�!�����H�|7�qv\Zx�ǁ\rk��x2��c�o���ҳ�qڌi�9��[�.m.�馛����k����擖�Bhʇ�d��m�r�yjzJ��[�!M��E��4��Pj��[�{��w\n�m�al$޼�����\"�xs3�����\0\\C��}���.���U5�mR�)�LMG�z�x�#�z�|ϩ5>����q��秕-��[WP�\n���\r��X�5�wI>Vݽ�(hݮ�@�w��<��	��\Zt+��=aD���?�&������A�O*0Ԑ���*FUV\'�qn\Z�=�x�g�\'�y�����V9�ML��k�.�t�I8��p�w�����r~�jF������f5�_���C�\\�y^:�K�:�|�xb�0@�ƙ�\0�UZ�����V@�݅�{�\0�7���_l���G��?3�:!�O�7��f\n*7q�]{1��U��8pᧁ�w{�S�y�����>��t�Ai�E֕\n����ظqc2�z��%8�Ko�o�H�,��\\t�#��\0�Ԑ�m\ZM]8*t!\Zm���C̡2��! &K�#.^>ԙ�k�A�B�����N��=��O�.��X�\Za���4�\r��%C�y�� �l�9x>�|_��FKk��e)-Z-�xnC���YIcI�]Z�[T�R�U�/8��.c�??�0�qrym�{�8L�4�%p�Z@�z��wc�}�I�����I3�e˖���M�\\4�,�\\��{�)!M�6�^c���L��\r�K��\rs��5{�N��	�9\\�r	pVYY�]v�ei�� \\�x1�/_����׿�5�\\�~Gc_�V�x�V��y�,��i9/�(:=0��ĳn)����G$!�\n���Y1u�Ct��3��鑀�߽�T�9�4���\"�-[�,i9�pf�ڵ�����~�: �4�u��䕜�#=&y�F�ixyY�K\r��e	s薈�((�iFz��]V<���Ⱏg�#I�m�$K�4�+��ߪU����7��իW�A�;v`�ҥiXv\Z�\n���ʑ�[�,�4�HK�x_ʧ	��`��&P��%��q�ٷ\rN�� -a�h0M4�\Z��\0�o���|GPF����<V�%ZK���)��C[ .J���5\Z��6���S�\n6ͮzY�*^�T�~f}/�C�k�V]hn����9/_YGowZ�FrM[������^*��Ҧ\0�U�l����oD�	�p�Lx����M��\0�=+�*�VM�����{ަѷ��@���9��M�$�.6_Wi���mV��!�n�p�[!���J�α\\Ҏ��0��q�b./Ts�8�\\6�����O�3��qt`��[�O���c�Ǽ&��M�4Y@���|=�-���guv����w���4R���+>k����A�?��ȼl�|lD�f+F	��\'˯��u�LG?8��iA[�`i����c.�&s��]i�!d��v�K�t|�V%����7M[�.�>��Q˾�[|�d���Q��o��/O��T+X��\\�g���;W���|�P%�i�L�����<!���3��PJN=0��-�^F���_�eZnL�Nͣ&Mo��ػN�d�	�!�?2�&�e�tqT\0#�c=�b�&5�f{�+V��#8SeZ�j����0�E�ٍ���4�W�,Z�Ϲ ���P��6�7K[5i�6Z΢K�-k �1�M~x��.\'��goJg������)�:<ha�ڡZ�\"����T,fUX\rǤϙ]����X����EA{�+�>i���m\\x���.�Ͽ�85�_�U-F��=�k@5&�5�6��/�4���!��4\r0��d�u9q���&d\Z�ie�,H��V��W�\ZA�W��8�eSC�u�dա��Z�?U��OX�m��\'�ßR�F�c��\0��#��Y�罠��wN>�\"��)���BK�Z��-(�M��*�2�\Z����׵LN�KAjMKz�MҀ�o�D1���ސ\r�&#��	��Đ�\'���Ǩr���^-���^� �i�lQ�Я�w�S5?�8�8d?�*ɉ�?>��<�5�~�f�H�-�����6(a�P\0%Mf�o��M�<?2�����t���� ��or8e,a,���II��.���\ZG�5�ՠ�W�p�@�kn!�מ\r��п��\0��0L�צQK����D�������z�T��&�\n5�ֳn�s���C��S\'3��O��=���`�/fU_#e0�W4�fd��7�!o��@qZJG���NEfL.A�\"T���7;\0+h��y����\r?^�/��&�/}��K`�\"3�/\'�7]������L���Y���e�=���g�>_�x�R8���ہ�|�I����T+�鲙\n��	�����J�w2(�+ޏ�δ���d��5�M�{�����|��~���V`�~��]�Λ�j�8�M�G��4��]�(�u�x��:���X,�E*��8���\n)��j@ճ��1g��z���K8��^T+��1��rsP\rr>b�/V�	��:�ۀM�\0�v���:�(�dXP�(�������{�{�W��X�т�\n@�tj\Z�\Z�*N�[~��٬xmLu��mi�s��q;�~:�ŷ�7�W&��t��ۀo�+���F�&kbf��<�!��`1�����5d��=\r({�p\Z��^���A�����\"�63I������$�Af������Su��QI3?IQ������@ԛ����/�=�e�U9��mC�q�L��?8��\\iӼ�<X�7L^����p�jפ���XmgaH	��!�3�\\*V��A���W�E@��T����n��*@�:�m��\Z^�Wl\'�X��Ńm�9�MAk�R}J��෧Y��j0�8������p�W�z6\"g\Z��\\\Z\0�\r��jD3�z�PАf$�f����	k�]V�r�!�\n���[>c	\\m��6�NcJ�ȧR#�̷�cZ.Nɢ o˴Բ�(TK��u�T�:-�!�ۏ=HS��iX��|��k�U�e�-\r��H�5R�j�iv�&��f�ƺ�N�74�P��C�k� \Z��W?�;�v�V�+��Y+�\ZhV�k;����$}\Z :���R(���i�К��<:��Әٵ	+�?+�Zz~�Ưb�����!�n#���k^y�<�ɺ���Ⱦ`)`m�sA���R�V[�4D�D�KZ�}�QZ�%�l�֓�M\0�y\0�L��N�]���u3�>�M�����G���C��Ɵ�[���N�@�3��9���s������;�՜����Q�1�J2�.������ߵki@H%�6�\'�]f�K��`�D6L�h�K���IS,�i2�Pt�Moƒ��a�oI}����狖��^�MoAov+:�˫�L��]b,6`\0����T�U�u=�xH�����0��K��r袰�T�$��r���P/$�ߤ#��q��%0K����I?���`�t��.Ӫ���Ϋc~?7}���$t�ck�L��M\0y�g�vʑ�����XHH������?}!�����\'m�]-(˿jc�JZJh:�����;i&%ֳ�9�#L�U��<���q�^��\Zc�����]�)iL+_��Ce�-��ΛS�t@㹞�}��_��Λ16�\\8�b�d]`=^64V�?j�Q( �����X��8���c1��@���:P�~ni>j�i��~%�Zjͨ\\�JQ!�r\rf�Ubí8�?��q��\"l�\rq��xD�?V�\r�����V���ikn�|50������������C�����/^l��r�t鳓_�_��9���7�l��6C���>yv$�~�ޱ��j�yб���B�i��ؚ��ݺu|˿jBi���d�V����u�]�_9.A\023�#NYHv�_��~�n��ތ���q��!\\����������h��/�<����-Aon;n��07�v,�����{n��_�6L,���Nk�J\ZU���}(����.^�O;.֫+k\"��=iF��`�R�4\\�A�ϱ������_��}��lհ���c��(\Zf�j��\'㏍#}� �������^��z?��n� �8��OP�O����̣�x=�vo��?})&��\"����J�O1�M))+xn�H� ߏ�G���L��d�mZ�Y��q���$\Z\'��t��.0����E8�)����vF��LJG�-}� A�{r\"�0�$Ѽ�U�&�؝@ѭ����X�:(V�raDC׀9��7��5茯������%�3�΢�D�����~ߤ�W�X�F�P��0�)��LcU­���E��9��S�c�Sz�2��2����۹���eoHgD�+_��a�u	�-f{�]�w�sd��h`����E<;�װ,Y4iz�͇xT[��>����ƃ1DaU@3��s_���9ĕ����:b�p��`/����5j>ya~�o����R��6�U�%��7D���y��K����W��{y5��%����uN�w�bZ�/�2��,b��x�{+�֚2�u��|����Z��z�A��bZ�zw��E�{\0��\"`n�s}���!��M�>�K֡I�:�ҝwCUq�DK���(���\\�g�rC>�,��p����J>_S+���d[�7	DҖ���Zo��=K�T��:�T�)�\Z�E�m5��c(����ƭ��魠ӕ|:�\"4j��\0Z߯�U��,X��G]DuϮ�X��!��{��Xi=����u�^(��k�^\\ݪ�j>��2�6�X\r�2�m����~auUB�Sr&�.B�Ĵ���A�uΝ��Ҩ�Z��$����X��,�Wo��4�NW�WkC\Z�O���/��&��?�\0F1\"w����.�o�B�� ό�Y-�j��{�h5���\r>%�����YY�(�-Ϊ��I=�x�ɺ[�5��P/��31VH���ǳZ��6�zS�%�˃������la�&�Z�u��֢:��|I^���e��w<���5��d~e��_V2�:�6��-��2��&ϗ��y�ϵ�|��֜�U5��#s���KAI`e���r�*��i�?�x���w4V�z�è�\'DK@l�ucZ �/\r\0�D�߯mhc���h�d��<H�׌�J	�q�c�uz_+�{��3�Z\'\'3נ��#_E���**��뮻p�q���\0~�_�ܴ-���+�V��Z�kb��w�Sz�y���+��6Z�ӸM�z�����Y^1��|�y�{p����x�A�\':��5\rQL���<0������`�������??��|Jww���d��Ǔ��>�4�9km.S23�Ĕ�Ԡ��������i(͓[�y�&UĖ;t뭷�S��8�\0�V�#~��БLߕfL:��D�JZ��I\r\Z��!y)���py3��*Y�ʔ��֠Ҍ��H�5�3�	9~>��:{���X��Ӽ�����Ͻ�yB��-��?K����P�8������>���i�X����N�-?k>	X�Q�U�A�:�o�x��1�r�\ZB�|;]�f��dYXcb�Y�*SH�g	����������i�@�X��X<��8��u(<�^3�q tӔh��П/67%Y��e��\0$����\"Zk�\\i�(īLy�)����dy�љ��,� \r�2x�9��X�\"�M:<&[࣓~���\'�f��5��*G���/���CI�R�{���W�`��Q3>�ЙL���7|\0���j�6�����m��Yk��&	��2�q��ը�y��ޯ~����a�\'k\'�K;kz3.|�2���w%��w�y�����=����������J�d^p�#��`����>��~;�8���|�_H�P��\n�}ɍh���~C~ݢ��k��p��_Ggl� �J�d�Y�k>U\n�[h`	^%��ɜ�����=�|�+q�UW�W��U\Z���匇�nP��b4�nݺOy�Sp�駧�?��?����v*+����,��½�mo�/�K|�c�h�%^�,K�6m��_�r<�!I#٧�\Z���,+�淧��\0�x=vo��\\��tߐ�\ZAtB���k0�HP3ڿ��\Z�Ӵ0��;��e[th��%kf�����d�	v��[:��8���n��4���?��Y2Ŭ�ܼys��ߛ����h���=�V���E�����j�{���\n��ޘ��[S����#�dm*��6� �s��~�m)������C�����-i���+�C��0= h�K�_+��mxbO�Y���E{]v:�S�|;�h�~\'g�K�5Q������l���y2��xh&�r6��x�9Ӝ���G�8�n߽�ګ�Ĳ�����n�̛���n��	�V\"�@���<Yv��^t|)\0\0 \0IDAT�\ZY�>� �ǋ��k�X��jB����h��+���=pBt�9��+����t���:h$>?)D��[n�%�i�����k嵨d�GSEm�r��<��^LNNb���������s/}M���b9��g���뇖e+͍7ޘ������S�����rY�ʴ̓��b�,�@�̾�	�`g��1-�ѯ��䑔q:���w�g<�������=?W��\Z�C�w�yNd��\"Hk]��8���?����q���w��]�M��o{�>���Cƒ�������������K~�#�c9�ӟ𖷼�{��RO��x~�����k��׾�5lذ���2�\'?���s���PY�r.�SR��i����}�C���e�Oa�^�I�=������@8ԓ�7��=g���x~򓟤���������7�<��iM����G7��g���Bt)8�z���8:;M���~05V�u���~f�CҫW\r��b^�V����X9��7��M��W��C=4� x��_��1l9�h��s�9o}�[�`�X\n�=O��f<�\' O=�T����=~��_��K/�4����Ƿ��-<��H��f�����	�<�O-���矏��>\Z^xa�;��q���Y�zV���B���~���e�:�� 95I�1oj9�,�����4!�oذ��o�6���%��oruX>��Ft�e�%\ZX{�l(������$�e��wl��דּ�J�ٰi4�`(\'=�aj-m��S�٘n�Q�jL.��p���\0N<�Ĥ���?����T?+D�S[��e/ji��?�q<���M��K.Iڎ�<餓�84�a\n�Rk�p�\r8�S�fy�3���C����/~�֭K&�ye�g?���#�<2���o~�gVׅ����?��?���<��统�ԧ���n�24��J>��:�S3��!���/��>�����|�#����7i.���Y�<����es�\0&ݬW���|g�	�\'���/�qK.4����X���<+1Jb�@��:$P�֤m������z��455��^��Ty��QR����S<�l̠̏Y~ы^��@����QG%m��}/�[�1�yTf릀�l�v�\'�(�?��5xt���s�������}m��#�He�L��5�I���g\'��@sF�J�1n������JK�X&�Ʊ�+��2��q	<��x$�������Yl,�\'�����yʛ�Sۓ&j?��������R0o�����Y.���*u:$ȴB�q�\"g�1��T�\\�����&�\'W�\0{�w҄�.g:���6/f`�ɤ���i~���\'�I\'>72�\Z�����?5;*5��2�q�O�r��m6�	�V̟Y�g��|֗�e}�u�Ԅ����%��r��h-da�j/�H���z�l�ٚ5kR���g����>�4.8���2JS��[c�Z��;!��V�\0�]�/�wd�J��B~��\ZR�h\'�����:H��{v�������W��;���)�<C�re>r����r懠`��*P[e��3}�ӟ^/�о���F�M�F@1�����2�<����$�O���	�q�p��uu� O���{���]V<���C�d�7d�Ҭ�Ѽ��_��<�̑��j]tQ�2�%��B_�S�����~w2�:ДS[r8���9��4�:P�r~�yi�YA>�+�!\Z�7ڡ� �-�n���+����v1���n|�w^��+��nՋ.�KT�A��Y�/���c�i��C���<�iOK>`�����)��Y����:��!��5��E�P㲷Os��N���Y��崝�7G����\0�+,��M��Ҫ�I��ds N�j�Oj�\\��w�K�Ӗ̓tt��hv�/K���7�9�����w���ۭ���`�G��H����a�G=�Qi�����<ɫ�����b~�azP��E���g?kr�2�9XV���d�Uw^�\ns����тe������߳_E��if�_�-a�ϫH�Q���9[��<���\'�*�I�z>�?ғ�U:��c�a��ub��g,��f���̇��4�p�����G�NB�g��=m���ڌ@�y@4 �s�#��ɼ��N�eo�IOzR�Vɿ�	�wG��yF(�������^`�p�5�ۘR�!C�\n)�V� ��D��hf��4�Pq�	��h\n��=D�\'��x\"��hV��6Kțӳ�P�ox�Ro�c��Q����C5�F3�r9��\'<�{l\Z^a\Z�i6�<�g�N�O8��q`|�`Y7�����ˬyF�X����d�9c����������Py�������ӻ�~��uo��Ѡ�ؐ����ĉ2��8Y��jb���Z~��Q�\'�ѧ��8SA�<�OL�#�_��W��/y�K����PKp6�+�H�cj|ϱA��q@���}o\Z�&@(�\"�d��@��\Z-����Rs��4R��~����-���0��)3�k�8���C0]~���t�^�e�d�`����яy�c������\'S�#�Vj-�\r��I�H9���=��i3.sh��L����/}g~9�)9��F�řv�X�P���Ӗl-��O�!��3��ޗ ψ�`�6]kG��򱀘M�C��S]d4�SCpp�SHl�9o�;��s8�3��e��\0��yZ����I �����G�M�I�K�\\��¤���X\Zg���7�1<Tv� >��O׍��SSs��{�*�\"�8���\r֋&���ke���!�=���)1�w�g��O�Ŏ㳑��?�S��3.l�|����3/�`� �8��zQ���g�~k��?�s�1�?huhS�\r6l�1.���I�����B��vZ\Z��\\([rv���\n�ڍ�$����>o��\'�)`�:Ȧ�X��ob��\'�����l�O�)	4�˽D>#\r��!}5�Ajj!T�/��e���l6!@I#�:�^,+���|eZjrփ���K�Ok���d��< ��XՒAJ�2-�1o��<��w޻�|YV^�;N4���G�l|��Bm��N�3*��+3�G�@�\0�����a%3غ�`/�Q�y�U2�B� 73���?󐫒u�˃��]6\rr?Ϧd:�1b�6\"-�s�\r-/��v!=~����N�O0>��xx���R�ol �Q\\�k\re�\n�a��&+vF$�y�2�{��KJ�zg���M����;�\0��Z�A�\0�ӑqPZ�˦$�~k��q��Z�0L�Շ��Q�I�nK��4Z��U\'��u�B�!�G�h��>OqJ>i9����K޺�z2�u�0�0�W ��1�J�+l}�e[���O�3d��du�<��T7M��w�t=-04Ѥ��:e!u\\hЍ����ȑCʭ��K!�m�ؘ�K��tr��l�C�ئd��d> \0mM�[�mKe���,[�p��Ɜ�3efY#�4{|����]�$���W�����ze�W�~���	�6����]⋧eu>ZX��l���Z*b&	�2�ںPYЗ�P��Rƪ��CK�H��ӱ�^�M�\n�\'Ş�\'>�	s��&��Xؼr�O%\r�� ^H�m���Σ[v�8�����+zڬI��\\�p�Gr)�r-�ji����U/�=��{��aP�pل�a�%�@���\n��K�>5#�L��p�\0�\0��s�{��+���v85��h�S���C&��_tf^����0�t�s�ߡ��q<*V�V	�l�-���f�~�ɔY��ky�7CP�r���4%`/h�:I?��i�x��^�2N����+NWFW̊�,���K\Z\"9�J\0�NG��\n��M���:�NS��C�~�=<�X�l�_/貽�ȥ:X|�dձ�@�$�i��R�!��bE��<i&���3ϯ���Z��t�,����ei3WS1^&��v��?S[��D�m��2=�X^����5#���|�3]>�)�|�)��8�X_�U��+>4ɉ��0`�Ғ�������Lbu���`&,N���{ե3�M�����;����=�\\��9��_�\n�~\nY��/�dX��`l�j�1^�??\"t}pO�4z\'�P���{7����#N�8��7���q��tZ�IJ7�!(F�1�/�Y�?�hI��ۂ�� �u��{F}=o�L�{1�j��޿+Tw�%|dA�\n�d4\r��_��Tyh�y�[���E�����i{:eɼd�~�Ϻ\r��|Rc$(�1u���};���ӵ��U�̆\0���h	�Mp���ۀ%{\0��\"�\0G���SKW�:�T1߷��\'ƀ{�D���;�N �FG��G�֪{�I�\\P�\Z����CP���\n�!�+�5O�yX��L��OZ��Ϳ�n���!����}�숖�[��u(�oj�f��V�>1]`n\Z�z�k\rp�-��-@o�_�ީH�1��Eܲ�����1T��gםD�&u���ܚ��f�AvR��B�����T9W�zn��+��΢36��|ڒ`0풖��6�P�Uښq����}����?!|7_�Lĸ	��}�A���^�@���y���i�\06��ˁ�[���\\�p���q��>0ұi}K�4bu�|m�x��)`����NۼR�������ۯzy���x�X}���!kF���q$qSbmF��\rz������\r�,�寧%�q�P?��=�T9Uma��\nk��Mb���}��^@��nx�ob�e�\0vݚ.����k��,�֦E/�2��w[�\Z�?\"\\�`����������4�Wo-�qx�	f^��6��K��Q�����a���$��΋�VA�����L�����ݱP9�QtF#;J�P<I�P��0>�ωe㘝�7���\0.��#�й\07_�l���<ykt�k\06��-aC	<��@.ݳg~֕o��td�(/�.�&�;ɩN�y����a��_���RF��y�P��xQ��]�-��濚�0�^Ǘ�w�~��a��q���&��^o\n���Dl��o������.���fw݆��?�A����a��[�WH.�^�YCHm���uM�w���WYA�s�u:]�f�����y���,����EK��/p��O���]�};��0��6��x+�	�^ea��)H���|����)-g+�_G��J�*灨��AT�arV���x��+��K��g��Xr0fw݄.>��X�	�87]�4 ޒ|B����#��K@\n�i8�4��VX�F��=H.���s�h�Y���H�9�����Y��)�zh��\r�vO�G���V+�tmp���g�n�M?z\nB��q���/{�vo�����c�y����hC݉�����:y�\'9)3���Fx����.`��*�\\��=T��U�0л�����,	�[�(+�Хr�;��6��ҀV^���h�I ���\'����;�xt���Sc�cBMh�L���ڄR�K�3��k®���=x�bo~40BO�-A��<���G�Uk���lh����8�7#u�Q�����j2�%@i��x�s�4�q_���&��8�$\'�9�._��z�a��Ĳrz��Ы��tV��T3;o�rP����#���W]��.}:��\'ѝ�/���k�FZ2�EK���S��1���\"�v��8\'D�\"�\Z�H�v���{�@��&�����[:���#����r,\r2�$��69��t�|L���ơ��x� Tǌ�\\�J�q�0+7�X�Y�:�1���\r]��������Ox\nB�>���\'����nAw�\Z��`\n~��Il���i���<�ٟN8�k�?��������㉡�t�\Z���V����kjp<\n��Tk�����C\0p�>7l3��nB�;�s֭E�ڪȴ̃@`Z��/S�B���s�/�x�E>��\rC��`!�� L�w=n��\Z\'<�xt:���˞����IS���]�c�<|�?\"���2�����.`�Z���\0��?ጾy��p�LDwlאb=of����~�x�cS��Jd�C_2u�o\n�&W���=��|�o��������|�-�czn��\\��L{�t��l`y|�=�L�M��>�a��,��b������#�/��˞��+�Ĳ1u��13u=����g� -��=SX��?��ɷ#�h���\\��V�MC�i�I%U�|����i�y.K�[�J\Zj�x�+���1b�-��\nM���8}?��M�CJ0�t:��>ol�&����);�n`є����X>O&�3.A\'��1j^�J|	�9ވ�~�T��W��A�Ew�jt�E��0s�m��W����>���4a�2��^�����U�����#���4�.Wz�\0h�}�����^\0+�E��EG���ȓ�NȰ4zT(����/���Ի�:-��L�9DM�k��x.\nčFM��ז�Qj<��BP���M�dz��C����S���ެ0�ce����al9�r,]�3S�(��S\0�]�tL��L,���MZW�Ҫ߈���������䆱һ�6���8�X`��;YkBrd����0�6o�1tHy����4���@�� ��B�D�Ń�s�MN�L����\0�z��Nf��d�|]�o�i�Y��\",^�P�M���ǰ{;0������}[~��9=�+����v$m�y�J�gY�%��$p�E���0�j��f����_,H�Q�ɟ�ݘ����@e��i�w�� �w���;�+VK��4��\0����3\r��3e��Af�	2����Ĳ�`b����\Zp|�\0t�K��U\0=?S��u��R5 =���s�~^����֭�#n�!-��\n��\0�� ���&ݼ��{&+�����U\\��w���9�^�����Yz.��Nͷ{�/1��`8����!��w�����}��\n%��۴���6ɣ�ß�	JO,i����2����9�Qb�W�R�:Ϝ������u��fB�p�hQ��clb\rvm�w��-�.&Wˀ���m�\\���{�\'׏�˪/�\\���M4�����c��T��M<�Y��\r�`˷��2����=�����&Ө�V2+\r^���*Ɨ�{n�0�g�c�NEgl)vm�-���I�Ʌ�V�m�%m����w�~�F\ZJy�i�0a�ض�$Pؒy��1��p\r�R�W��l���|K\Z��W�v&�n�ef���L$�m��3���/�N����\'צ�a��˽�V\Z�#���ޝ��{ �ϠWd�/�����}�z_h(?�<����$�ɣ�y���+e�F�hh�G��i�U\"��\'�����llQH�;�JY�>��DOI+V_�݌p��p_~q�3]U� -?�ى8�abzd�Mc��fB,��:«Ta����K�c�|�5V���x�ͪ�.���M��Ӻ\Z�1�z�E7�5�V�o,-�{]�7�+?\n�汃�\0~��4ӊ�lf\re�?g��ß�p���U�m:4P\09�-��Uy͔�I[��J��Ը~W2�M���:���Eò|�Fm����<����\"����[oA� n�q����������H���K�]��D�㏁k�u.��NH���?-�K&����NW�q��?���6\rb/��ޫ�Bͺ�/��Ʈ�J���n����9����ownL��b�>�6�y�C�3M�m�2�{��S��n�U�LS}8���R���!�؀sT��o14���I�\Z0m��1�Xt��m�]--ؔ�λײC�i���A�gz��5:{���#��\Z����8\\@�#�DiC��撿%Y\"��cIM #k�D�I�����,Z89M^��爵\0-AY����JA7,/�6&VkO-`���0��`���+�T��Fʖ\n��ƺl�lD]��:9���ZS2պP�t�g~�Y�f�&_K\rnm�u�6k�̸��*_�oe�w\r�,-�>��K��[�(5DY^G�6� Oci¥�-�j�T�}\'��Fh�@�gp���n:^�AXt鎠�i�-��8fO�[W�~]��!:,DgV�䧥ͬ��a0�Cszy�Y)���Dϧj��|n���zX��җ,�G��Q��*��	7ѥMqT~�U��cUHgj1Jk;\r6y���DkY\Z�d­g%��\Z���ů���Ѥ=���@j���y�=lKY��\ZDI�P3F�β�V��Q2V���{��|�N+����lc:�� �K���YSݴK��~�,���|�U�n����/�\nkj��=.H����6Q�M�!\0\0,IDAT��[��k���`s���Z\\�/w�Yy�4Z+[\0��������g�<^h`iE��sr��ه\Z�M4��\\\0f��F K��5=%�q�1�uv�a��\\~nM�PZ�v|�xtP�t�mh����ŕ�r �d>��tc�5����~fY\n�]76L�6���yV��-1�0���ў�)�A�\Z�ήT+���K�y��54M�����s�Ԗ�������Be�+�װj-h1ߪ��G���,F�B4i���j#+x.Q����ϧ��Z��O(U�	��OI��x4�ܓ�+���	2��������_����{=xտ���\n�j1��Sk��Ѹ+��t9V��kTS��<jm���̾�nxZ֓�g�u���0zُw��%���֣�C2Gу�i�=!��b4;�k1�`e�|-k\0ahD^]d�s:K�k��xү�ʱ��~fiMO�zu���q-�yV�Ɲ%�F�Y��i��q=�噔R�e�:	Ak��6n����@���@t�t]b�AJ�EV��#Gdڒ��&xJ�ӂ0���楌���&�5�;��+e�$h/���� K{zLӕ�e[�7�Qu����3�\Zh��&�6Y���^�B7\Z��顣����:K�\r��͞�Z�f�\nj�z�F��[L(�%�ͬ�K����/����u~M|��Z��2Y�(50��-��^h���9�I��#G���+},]�6��\0#ǎ<�K�eŽ^������.�λIy�)ig�a�w��ih!AB�H�fգ�\\��A��u1�\'\0�d�4�(y�wI�yB�*]bJ�KѤi-�큠�.�t�Gp-7D_�-���m���<3�!%k$����ht�J*iA�}[�l����h�iJ�%�4��+����O(�E����%Za�G����L�9�A�&�k�3=�/�������5U�ܒ��Z����Ic6��u.���k��ﳴ<��`\0I��������� ����~V�!+�	l.�R�8˜�@꽇juy�Kפ]��AӮ�/�2�x(�4M��ѤZ�h4�,�[�_��T�!%O֥�#��n�(k�U����բJs�:���|�-m�Zx���ϛ���mi�I->y\0���x�����dJ���^��d~=�Wb�z��8�U#)�I���Ђ��=��V��(C��%w����5�,��g��K����\rݱ�Lv�]��bU�I#��M�X���i���\0��%���b��ƿт��.��r���S�eY��<�+��U:P��責(Gʵ2��z�5�����f�WAM���~���4{	(MCG^]�̽����e�\Z:����][�x\r���\Z|�,�w�\",��1�S�m���`\0�TyO�%Sf��[Jf�k��rKگH\0���.�B��ŋ&\r��88��C��0J{f--���敭����0J�(�#C�P�U^Pr�ܣ.�VY����BO�i:���4�gre�e�%O�8���,j@��`]�6��ctT�I�u{y{�I�����²�O�@��TvI;Z�:kv�3���)V��8A��:D~�$���=-�5c�V�1I/��Ը��u�-��V���o=�|ɟ����|��a�a)�Dk�����[�G�)o����x�W�C�&�ϔt����F�B��@��Ҳz����D�Ui�g��򧵒�I�X�<\ra�A�3�s\rRI�3-Y(0�� ��:}�1{�6�j�Z�=�oL˭��aVɗ�?A3��t[�2_��y6��J�i�6ڭt`�.7�9�&Y.��,��Y>ٱ��7mLʾ��y�sSҟ:��rY!]A�$�tѻ*1֫��6W��hʷ\r-My��@j��I�y��6��Ug�Lkm)�\Z����z�	�xC\r���Ӂx�/^U\0\0\0\0IEND�B`�','2022-01-11'),(2,'daniel.hiebeler@student.htldornbirn.at','majo','$2b$04$UMfL9JXMeN0IQ8e5.ARbqOHwUVRsKmNcqKwsPzIoDYagnstw0Db5y','',1,'Mathias','Johannsen','','','','',0,'Austria','','','','����\0JFIF\0,,\0\0��\0VExif\0\0MM\0*\0\0\0\0\Z\0\0\0\0\0\0\0>\0\0\0\0\0\0\0F(\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0,\0\0\0\0\0,\0\0\0��\0,Photoshop 3.0\08BIM\0\0\0\0\0Z\0%G\0\0\0\0���http://ns.adobe.com/xap/1.0/\0<?xpacket begin=\'﻿\' id=\'W5M0MpCehiHzreSzNTczkc9d\'?>\n<x:xmpmeta xmlns:x=\'adobe:ns:meta/\' x:xmptk=\'Image::ExifTool 11.88\'>\n<rdf:RDF xmlns:rdf=\'http://www.w3.org/1999/02/22-rdf-syntax-ns#\'>\n\n <rdf:Description rdf:about=\'\'\n  xmlns:tiff=\'http://ns.adobe.com/tiff/1.0/\'>\n  <tiff:ResolutionUnit>2</tiff:ResolutionUnit>\n  <tiff:XResolution>300/1</tiff:XResolution>\n  <tiff:YResolution>300/1</tiff:YResolution>\n </rdf:Description>\n\n <rdf:Description rdf:about=\'\'\n  xmlns:xmpMM=\'http://ns.adobe.com/xap/1.0/mm/\'>\n  <xmpMM:DocumentID>adobe:docid:stock:9f85673c-12d1-490e-986f-b041b3d63738</xmpMM:DocumentID>\n  <xmpMM:InstanceID>xmp.iid:1ac5da1c-3984-4ea7-9a1b-f2733998a928</xmpMM:InstanceID>\n </rdf:Description>\n</rdf:RDF>\n</x:xmpmeta>\n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n                                                                                                    \n<?xpacket end=\'w\'?>��\0C\0	\Z!\Z\"$\"$��\0C��\0hh\0��\0\0\0\0\0\0\0\0\0\0\0\0\0��\0;\0	\0\0\0\0\0!1AT�\"Uaq���$BRr����#3bQ�2����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0?\0�D��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\00�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��u,<\n~�z)����T�D*�����LӇ�E�U����Q���Z��͹O���f�V�)�o���>$���u�Z�VmʽU�U������e�f)�Ƣ����ɟt�#sV;R�ϧ�ע�����T~I���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0V5�yU��U1ʫ�q����n���Uu�u�5UT�33�ʒ�\0\0\03Eu[�+������bv��@��U8ڍQ<�����i�Vj�ƀ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���bb���Z�ە���\0��}��fꬤ�\0\0\0\0\0-=�&j�Nʯ}�Y�g�\0Y�=��Vj�ƀ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#�A������1��y�������3\ry��������ա�\0\0\0\0\0\0f&bbbf&9��`=���CM��SKO�r?�;>�n/\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)}5ʛڝ8�>m�v������+��\0\0\0\0\0\0\0�	ʛ:�X�>m�v��\0h��5��%@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0GX<�R�7������?��.q�\0\0\0\0\0\0\0��.͍C�O�i��n=+�a\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\'�}����j��\0\0\0\0\0\0\04�=��\ny�{�@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0:��9V��U�S�EuS�Z\Z�\0\0\0\0\0\0\01-�ܫV���r�}�N��B�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��ӏ�ݪ#joD\\�ϯ��bu�\0\0\0\0\0\0\0[�Xӑ�Z�czl�ܟ˫��kq|J�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0L0g+N���;��ޮ]���ی�RT�\0\0\0\0\0\0\0]��8�t�\\��dmW��ϚuY��4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0c�i�\n/It����~�vw�~��ߒ�S��k\0\0\0\0\0\0�ҧP��K��Z��\\����6n�1z�Q�rJ�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��rlWb�]��i�\\�o���t�w\Zg͹�W���VjwM`\0\0\0\0%t-��\\WV���|�u���\0�n�2��-cc�b�E�#h�J�@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������ci���A^�:/b���\Z��s�\'����+��F��3�ص�1��*�|6�8{v�k\0=@���5���ůɟ�\\y4�啱bҺ/b�����\"��ʈ���+s\Zi�i�i��b6���!�d\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#�P4��ƽ�\\{7? �������Â���65��cٷ�h��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0*��i���)�9���\\��`c�M�+&��������ʅ��N�rf,�f�vmO�>�leqW���<���v�؅|�}S�\nq}S�\nq}S�\nq}S�\nq}S�\nq}S�\nq}S�\nq}S�\nq}S�\nq}S�\nq}S�\n�����O,�����܅v�t�P�?ަ�����ϾT�I�2&)��cW?�>��YST�MT�T�S<�bw�cY\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0~���i���>]ڣ̷L�_�=fe*��j�z�{߹����t�>~�VdMp��\0\0\0\0\0\0\0\0\0\0\0�+U�ӫ������Z��3���#sb��ڕ��S�]�<�uO8���֘�ڐ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Fk���3xڻ��\0�����fDȽw\"�w�W5ܮw���Z\Z�\0\0\0\0\0\0\0\0\0\0\0\0\01�]ǿM�5�(��;{�5[z�4��E�?�D~��F��jL\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\Z��-���Ƚ;Qn���:�r��f\\ɽ>uS�;)�ȅ!��\0\0\0\0\0\0\0\0\0\0\0\0\0\0ѧe��̣&����8�;bF��p�-�b�ȳ;�r���6�\0\0\0\0\0\0\0\0\0\0\0\0\0\0���6|�XO(������-嚫� \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�t6|���)���G�)�r�1�\0\0\0\0\0\0\0\0\0\0\0\0\0��l��Բ27�*�>O�9G�\nĹZ�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ui����o�Sr<�d�эǤ%@\0\0\0\0\0\0\0\0\0\0\0\0\0џs�pr.��UO�&4���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0;$��s�pl]�������\0\0\0\0\0\0\0\0\0\0\0\0ɬS]zN]骪�TE1���\n�{�O�*���{�O�%!�5���Hp�G���rR3Q�9>���{�O�%!�5���Hp�G���rR3Q�9>���{�O�%!�5���Hp�G���rR3Q�9>���{�O�%!�5���Hp�G���rR3Q�9>���{�O�%!�5���Hp�G���rR3Q�9>���{�O�%!�5���Hp�G���rR3Q�9>���Mti8�\\��k��14�m1;%X�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��','2022-01-11');
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

-- Dump completed on 2022-01-11 23:08:10
