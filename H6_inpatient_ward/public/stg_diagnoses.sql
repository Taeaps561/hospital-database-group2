CREATE TABLE public.stg_diagnoses (
    diagnosis_id text,
    icd_code text,
    diagnosis_name text,
    diagnosis_category text
);


ALTER TABLE public.stg_diagnoses OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16526)
-- Name: stg_doctors; Type: TABLE; Schema: public; Owner: postgres
--

COPY public.stg_diagnoses (diagnosis_id, icd_code, diagnosis_name, diagnosis_category) FROM stdin;
DX0001	ICD-1001	Anemia	Chronic
DX0002	ICD-1002	Migraine	Chronic
DX0003	ICD-1003	Coronary Artery Disease	Acute
DX0004	ICD-1004	Anemia	Chronic
DX0005	ICD-1005	Gastritis	Acute
DX0006	ICD-1006	Hypertension	Infectious
DX0007	ICD-1007	Asthma	Non-communicable
DX0008	ICD-1008	Cancer	Chronic
DX0009	ICD-1009	Diabetes Mellitus	Acute
DX0010	ICD-1010	Fracture	Infectious
DX0011	ICD-1011	Diabetes Mellitus	Non-communicable
DX0012	ICD-1012	Cancer	Infectious
DX0013	ICD-1013	Pneumonia	Infectious
DX0014	ICD-1014	Diabetes Mellitus	Non-communicable
DX0015	ICD-1015	Cancer	Chronic
DX0016	ICD-1016	Diabetes Mellitus	Chronic
DX0017	ICD-1017	Sepsis	Chronic
DX0018	ICD-1018	Hypertension	Non-communicable
DX0019	ICD-1019	Appendicitis	Chronic
DX0020	ICD-1020	UTI	Non-communicable
DX0021	ICD-1021	Stroke	Infectious
DX0022	ICD-1022	Hypertension	Chronic
DX0023	ICD-1023	Asthma	Acute
DX0024	ICD-1024	Gastritis	Non-communicable
DX0025	ICD-1025	Anemia	Infectious
DX0026	ICD-1026	Cancer	Infectious
DX0027	ICD-1027	Pneumonia	Acute
DX0028	ICD-1028	Cancer	Non-communicable
DX0029	ICD-1029	Fracture	Infectious
DX0030	ICD-1030	UTI	Infectious
DX0031	ICD-1031	Appendicitis	Chronic
DX0032	ICD-1032	Migraine	Acute
DX0033	ICD-1033	Sepsis	Chronic
DX0034	ICD-1034	Stroke	Infectious
DX0035	ICD-1035	COVID-19	Infectious
DX0036	ICD-1036	Diabetes Mellitus	Non-communicable
DX0037	ICD-1037	Cancer	Non-communicable
DX0038	ICD-1038	Appendicitis	Acute
DX0039	ICD-1039	Appendicitis	Acute
DX0040	ICD-1040	Diabetes Mellitus	Acute
DX0041	ICD-1041	Stroke	Acute
DX0042	ICD-1042	Anemia	Chronic
DX0043	ICD-1043	Gastritis	Acute
DX0044	ICD-1044	Coronary Artery Disease	Acute
DX0045	ICD-1045	Migraine	Acute
DX0046	ICD-1046	UTI	Infectious
DX0047	ICD-1047	Chronic Kidney Disease	Non-communicable
DX0048	ICD-1048	Dermatitis	Chronic
DX0049	ICD-1049	Coronary Artery Disease	Acute
DX0050	ICD-1050	Depression	Infectious
DX0051	ICD-1051	Asthma	Non-communicable
DX0052	ICD-1052	Dengue Fever	Chronic
DX0053	ICD-1053	Stroke	Non-communicable
DX0054	ICD-1054	Gastritis	Acute
DX0055	ICD-1055	Dengue Fever	Acute
DX0056	ICD-1056	Anemia	Infectious
DX0057	ICD-1057	Chronic Kidney Disease	Infectious
DX0058	ICD-1058	Sepsis	Chronic
DX0059	ICD-1059	Stroke	Infectious
DX0060	ICD-1060	UTI	Non-communicable
DX0061	ICD-1061	Anemia	Chronic
DX0062	ICD-1062	Appendicitis	Infectious
DX0063	ICD-1063	UTI	Acute
DX0064	ICD-1064	Gastritis	Non-communicable
DX0065	ICD-1065	Gastritis	Infectious
DX0066	ICD-1066	Asthma	Non-communicable
DX0067	ICD-1067	Depression	Non-communicable
DX0068	ICD-1068	Migraine	Acute
DX0069	ICD-1069	Asthma	Infectious
DX0070	ICD-1070	Migraine	Chronic
DX0071	ICD-1071	Depression	Acute
DX0072	ICD-1072	Dengue Fever	Non-communicable
DX0073	ICD-1073	Diabetes Mellitus	Non-communicable
DX0074	ICD-1074	Dengue Fever	Infectious
DX0075	ICD-1075	Fracture	Infectious
DX0076	ICD-1076	Sepsis	Acute
DX0077	ICD-1077	COVID-19	Infectious
DX0078	ICD-1078	Anemia	Acute
DX0079	ICD-1079	Chronic Kidney Disease	Infectious
DX0080	ICD-1080	Diabetes Mellitus	Infectious
DX0081	ICD-1081	COVID-19	Chronic
DX0082	ICD-1082	Anemia	Chronic
DX0083	ICD-1083	Pneumonia	Chronic
DX0084	ICD-1084	Migraine	Infectious
DX0085	ICD-1085	Dermatitis	Chronic
DX0086	ICD-1086	Diabetes Mellitus	Chronic
DX0087	ICD-1087	Cancer	Chronic
DX0088	ICD-1088	Coronary Artery Disease	Acute
DX0089	ICD-1089	Cancer	Non-communicable
DX0090	ICD-1090	Fracture	Non-communicable
DX0091	ICD-1091	Stroke	Acute
DX0092	ICD-1092	Anemia	Chronic
DX0093	ICD-1093	Migraine	Chronic
DX0094	ICD-1094	Migraine	Acute
DX0095	ICD-1095	Dermatitis	Acute
DX0096	ICD-1096	Cancer	Acute
DX0097	ICD-1097	Hypertension	Non-communicable
DX0098	ICD-1098	Gastritis	Acute
DX0099	ICD-1099	Pneumonia	Infectious
DX0100	ICD-1100	Hypertension	Infectious
DX0101	ICD-1101	Dermatitis	Infectious
DX0102	ICD-1102	Gastritis	Infectious
DX0103	ICD-1103	Dermatitis	Acute
DX0104	ICD-1104	UTI	Chronic
DX0105	ICD-1105	Dermatitis	Acute
DX0106	ICD-1106	Anemia	Chronic
DX0107	ICD-1107	Asthma	Infectious
DX0108	ICD-1108	Stroke	Acute
DX0109	ICD-1109	Influenza	Infectious
DX0110	ICD-1110	UTI	Chronic
DX0111	ICD-1111	Influenza	Acute
DX0112	ICD-1112	Dengue Fever	Infectious
DX0113	ICD-1113	Dermatitis	Chronic
DX0114	ICD-1114	Dermatitis	Acute
DX0115	ICD-1115	Pneumonia	Chronic
DX0116	ICD-1116	Asthma	Acute
DX0117	ICD-1117	Migraine	Infectious
DX0118	ICD-1118	Migraine	Non-communicable
DX0119	ICD-1119	Depression	Non-communicable
DX0120	ICD-1120	Migraine	Non-communicable
DX0121	ICD-1121	Coronary Artery Disease	Chronic
DX0122	ICD-1122	Sepsis	Chronic
DX0123	ICD-1123	Influenza	Non-communicable
DX0124	ICD-1124	Cancer	Non-communicable
DX0125	ICD-1125	Influenza	Non-communicable
DX0126	ICD-1126	Cancer	Infectious
DX0127	ICD-1127	Migraine	Non-communicable
DX0128	ICD-1128	Hypertension	Acute
DX0129	ICD-1129	Sepsis	Acute
DX0130	ICD-1130	COVID-19	Non-communicable
DX0131	ICD-1131	Asthma	Chronic
DX0132	ICD-1132	Hypertension	Acute
DX0133	ICD-1133	Chronic Kidney Disease	Chronic
DX0134	ICD-1134	UTI	Infectious
DX0135	ICD-1135	Stroke	Non-communicable
DX0136	ICD-1136	Gastritis	Chronic
DX0137	ICD-1137	Cancer	Non-communicable
DX0138	ICD-1138	Anemia	Non-communicable
DX0139	ICD-1139	Diabetes Mellitus	Chronic
DX0140	ICD-1140	Dermatitis	Chronic
DX0141	ICD-1141	Migraine	Infectious
DX0142	ICD-1142	Gastritis	Non-communicable
DX0143	ICD-1143	Depression	Acute
DX0144	ICD-1144	Coronary Artery Disease	Non-communicable
DX0145	ICD-1145	COVID-19	Non-communicable
DX0146	ICD-1146	Gastritis	Chronic
DX0147	ICD-1147	Fracture	Infectious
DX0148	ICD-1148	Hypertension	Acute
DX0149	ICD-1149	Sepsis	Non-communicable
DX0150	ICD-1150	Appendicitis	Chronic
DX0151	ICD-1151	Asthma	Non-communicable
DX0152	ICD-1152	Sepsis	Infectious
DX0153	ICD-1153	Sepsis	Acute
DX0154	ICD-1154	Gastritis	Chronic
DX0155	ICD-1155	Dengue Fever	Acute
DX0156	ICD-1156	Appendicitis	Chronic
DX0157	ICD-1157	Pneumonia	Chronic
DX0158	ICD-1158	Migraine	Non-communicable
DX0159	ICD-1159	Coronary Artery Disease	Acute
DX0160	ICD-1160	COVID-19	Non-communicable
DX0161	ICD-1161	Dengue Fever	Chronic
DX0162	ICD-1162	Dengue Fever	Chronic
DX0163	ICD-1163	Diabetes Mellitus	Acute
DX0164	ICD-1164	Chronic Kidney Disease	Acute
DX0165	ICD-1165	Hypertension	Non-communicable
DX0166	ICD-1166	Diabetes Mellitus	Non-communicable
DX0167	ICD-1167	Migraine	Acute
DX0168	ICD-1168	Chronic Kidney Disease	Chronic
DX0169	ICD-1169	Coronary Artery Disease	Infectious
DX0170	ICD-1170	Sepsis	Non-communicable
DX0171	ICD-1171	Anemia	Non-communicable
DX0172	ICD-1172	Fracture	Chronic
DX0173	ICD-1173	Anemia	Chronic
DX0174	ICD-1174	Asthma	Chronic
DX0175	ICD-1175	COVID-19	Acute
DX0176	ICD-1176	Anemia	Chronic
DX0177	ICD-1177	Dengue Fever	Chronic
DX0178	ICD-1178	Stroke	Chronic
DX0179	ICD-1179	Gastritis	Infectious
DX0180	ICD-1180	Influenza	Chronic
DX0181	ICD-1181	UTI	Non-communicable
DX0182	ICD-1182	Appendicitis	Acute
DX0183	ICD-1183	Stroke	Acute
DX0184	ICD-1184	COVID-19	Chronic
DX0185	ICD-1185	COVID-19	Non-communicable
DX0186	ICD-1186	Dengue Fever	Acute
DX0187	ICD-1187	Sepsis	Infectious
DX0188	ICD-1188	Asthma	Acute
DX0189	ICD-1189	Asthma	Acute
DX0190	ICD-1190	Dermatitis	Non-communicable
DX0191	ICD-1191	Dengue Fever	Infectious
DX0192	ICD-1192	Gastritis	Non-communicable
DX0193	ICD-1193	Appendicitis	Non-communicable
DX0194	ICD-1194	Stroke	Infectious
DX0195	ICD-1195	Hypertension	Acute
DX0196	ICD-1196	Asthma	Chronic
DX0197	ICD-1197	COVID-19	Non-communicable
DX0198	ICD-1198	Asthma	Chronic
DX0199	ICD-1199	Influenza	Non-communicable
DX0200	ICD-1200	Hypertension	Acute
DX0201	ICD-1201	Dengue Fever	Chronic
DX0202	ICD-1202	Dermatitis	Acute
DX0203	ICD-1203	Gastritis	Acute
DX0204	ICD-1204	Dengue Fever	Chronic
DX0205	ICD-1205	Gastritis	Acute
DX0206	ICD-1206	Anemia	Acute
DX0207	ICD-1207	Fracture	Chronic
DX0208	ICD-1208	Cancer	Non-communicable
DX0209	ICD-1209	Cancer	Chronic
DX0210	ICD-1210	Coronary Artery Disease	Acute
DX0211	ICD-1211	UTI	Infectious
DX0212	ICD-1212	Cancer	Acute
DX0213	ICD-1213	Appendicitis	Infectious
DX0214	ICD-1214	Fracture	Chronic
DX0215	ICD-1215	Depression	Infectious
DX0216	ICD-1216	Pneumonia	Acute
DX0217	ICD-1217	COVID-19	Chronic
DX0218	ICD-1218	Diabetes Mellitus	Non-communicable
DX0219	ICD-1219	UTI	Acute
DX0220	ICD-1220	Dermatitis	Infectious
DX0221	ICD-1221	Dengue Fever	Infectious
DX0222	ICD-1222	Influenza	Non-communicable
DX0223	ICD-1223	Diabetes Mellitus	Infectious
DX0224	ICD-1224	Stroke	Chronic
DX0225	ICD-1225	Hypertension	Infectious
DX0226	ICD-1226	Migraine	Acute
DX0227	ICD-1227	Appendicitis	Non-communicable
DX0228	ICD-1228	UTI	Infectious
DX0229	ICD-1229	Diabetes Mellitus	Non-communicable
DX0230	ICD-1230	Gastritis	Non-communicable
DX0231	ICD-1231	Hypertension	Non-communicable
DX0232	ICD-1232	Fracture	Acute
DX0233	ICD-1233	Dengue Fever	Acute
DX0234	ICD-1234	Dermatitis	Acute
DX0235	ICD-1235	COVID-19	Infectious
DX0236	ICD-1236	Migraine	Infectious
DX0237	ICD-1237	Hypertension	Non-communicable
DX0238	ICD-1238	Stroke	Acute
DX0239	ICD-1239	Hypertension	Chronic
DX0240	ICD-1240	Cancer	Chronic
DX0241	ICD-1241	Diabetes Mellitus	Acute
DX0242	ICD-1242	Stroke	Non-communicable
DX0243	ICD-1243	COVID-19	Non-communicable
DX0244	ICD-1244	Stroke	Non-communicable
DX0245	ICD-1245	UTI	Acute
DX0246	ICD-1246	UTI	Acute
DX0247	ICD-1247	Chronic Kidney Disease	Chronic
DX0248	ICD-1248	Hypertension	Acute
DX0249	ICD-1249	Dengue Fever	Chronic
DX0250	ICD-1250	Coronary Artery Disease	Chronic
DX0251	ICD-1251	Fracture	Infectious
DX0252	ICD-1252	Stroke	Chronic
DX0253	ICD-1253	Sepsis	Acute
DX0254	ICD-1254	Influenza	Infectious
DX0255	ICD-1255	Dermatitis	Acute
DX0256	ICD-1256	Dengue Fever	Chronic
DX0257	ICD-1257	Chronic Kidney Disease	Chronic
DX0258	ICD-1258	Diabetes Mellitus	Non-communicable
DX0259	ICD-1259	Depression	Acute
DX0260	ICD-1260	Sepsis	Infectious
DX0261	ICD-1261	Hypertension	Acute
DX0262	ICD-1262	Coronary Artery Disease	Infectious
DX0263	ICD-1263	Migraine	Chronic
DX0264	ICD-1264	Influenza	Acute
DX0265	ICD-1265	Sepsis	Infectious
DX0266	ICD-1266	Cancer	Chronic
DX0267	ICD-1267	Stroke	Acute
DX0268	ICD-1268	Dermatitis	Non-communicable
DX0269	ICD-1269	UTI	Non-communicable
DX0270	ICD-1270	Coronary Artery Disease	Chronic
DX0271	ICD-1271	Coronary Artery Disease	Non-communicable
DX0272	ICD-1272	Anemia	Infectious
DX0273	ICD-1273	COVID-19	Infectious
DX0274	ICD-1274	Dermatitis	Infectious
DX0275	ICD-1275	Pneumonia	Acute
DX0276	ICD-1276	Sepsis	Acute
DX0277	ICD-1277	Diabetes Mellitus	Chronic
DX0278	ICD-1278	Chronic Kidney Disease	Infectious
DX0279	ICD-1279	Anemia	Non-communicable
DX0280	ICD-1280	Migraine	Chronic
DX0281	ICD-1281	Stroke	Chronic
DX0282	ICD-1282	COVID-19	Acute
DX0283	ICD-1283	Diabetes Mellitus	Acute
DX0284	ICD-1284	Sepsis	Acute
DX0285	ICD-1285	Fracture	Non-communicable
DX0286	ICD-1286	Diabetes Mellitus	Non-communicable
DX0287	ICD-1287	UTI	Infectious
DX0288	ICD-1288	Dermatitis	Acute
DX0289	ICD-1289	Stroke	Non-communicable
DX0290	ICD-1290	Dermatitis	Acute
DX0291	ICD-1291	Stroke	Acute
DX0292	ICD-1292	Hypertension	Infectious
DX0293	ICD-1293	Influenza	Infectious
DX0294	ICD-1294	Coronary Artery Disease	Infectious
DX0295	ICD-1295	Fracture	Acute
DX0296	ICD-1296	Stroke	Acute
DX0297	ICD-1297	Influenza	Acute
DX0298	ICD-1298	Influenza	Acute
DX0299	ICD-1299	Dengue Fever	Acute
DX0300	ICD-1300	Asthma	Acute
DX0301	ICD-1301	Pneumonia	Non-communicable
DX0302	ICD-1302	Influenza	Acute
DX0303	ICD-1303	Dengue Fever	Non-communicable
DX0304	ICD-1304	Coronary Artery Disease	Acute
DX0305	ICD-1305	COVID-19	Chronic
DX0306	ICD-1306	Pneumonia	Acute
DX0307	ICD-1307	Stroke	Chronic
DX0308	ICD-1308	UTI	Acute
DX0309	ICD-1309	Dermatitis	Chronic
DX0310	ICD-1310	Appendicitis	Infectious
DX0311	ICD-1311	Stroke	Non-communicable
DX0312	ICD-1312	Stroke	Infectious
DX0313	ICD-1313	Depression	Acute
DX0314	ICD-1314	Migraine	Chronic
DX0315	ICD-1315	Anemia	Chronic
DX0316	ICD-1316	Fracture	Infectious
DX0317	ICD-1317	Pneumonia	Chronic
DX0318	ICD-1318	Pneumonia	Non-communicable
DX0319	ICD-1319	COVID-19	Chronic
DX0320	ICD-1320	COVID-19	Acute
DX0321	ICD-1321	Hypertension	Infectious
DX0322	ICD-1322	Dengue Fever	Non-communicable
DX0323	ICD-1323	Diabetes Mellitus	Infectious
DX0324	ICD-1324	Dermatitis	Acute
DX0325	ICD-1325	Hypertension	Acute
DX0326	ICD-1326	Diabetes Mellitus	Acute
DX0327	ICD-1327	Depression	Non-communicable
DX0328	ICD-1328	Anemia	Chronic
DX0329	ICD-1329	Fracture	Infectious
DX0330	ICD-1330	Chronic Kidney Disease	Non-communicable
DX0331	ICD-1331	Stroke	Non-communicable
DX0332	ICD-1332	Fracture	Acute
DX0333	ICD-1333	Chronic Kidney Disease	Non-communicable
DX0334	ICD-1334	Asthma	Infectious
DX0335	ICD-1335	Gastritis	Infectious
DX0336	ICD-1336	Pneumonia	Infectious
DX0337	ICD-1337	Coronary Artery Disease	Infectious
DX0338	ICD-1338	UTI	Chronic
DX0339	ICD-1339	Anemia	Acute
DX0340	ICD-1340	Chronic Kidney Disease	Acute
DX0341	ICD-1341	Pneumonia	Non-communicable
DX0342	ICD-1342	Sepsis	Non-communicable
DX0343	ICD-1343	Sepsis	Infectious
DX0344	ICD-1344	UTI	Acute
DX0345	ICD-1345	UTI	Chronic
DX0346	ICD-1346	Sepsis	Non-communicable
DX0347	ICD-1347	Coronary Artery Disease	Infectious
DX0348	ICD-1348	Asthma	Infectious
DX0349	ICD-1349	Coronary Artery Disease	Chronic
DX0350	ICD-1350	Diabetes Mellitus	Non-communicable
DX0351	ICD-1351	Chronic Kidney Disease	Acute
DX0352	ICD-1352	Chronic Kidney Disease	Chronic
DX0353	ICD-1353	Migraine	Non-communicable
DX0354	ICD-1354	Influenza	Acute
DX0355	ICD-1355	Sepsis	Non-communicable
DX0356	ICD-1356	COVID-19	Acute
DX0357	ICD-1357	Dermatitis	Acute
DX0358	ICD-1358	Hypertension	Chronic
DX0359	ICD-1359	Gastritis	Non-communicable
DX0360	ICD-1360	Gastritis	Infectious
DX0361	ICD-1361	Cancer	Chronic
DX0362	ICD-1362	Anemia	Non-communicable
DX0363	ICD-1363	Asthma	Non-communicable
DX0364	ICD-1364	Diabetes Mellitus	Infectious
DX0365	ICD-1365	Diabetes Mellitus	Acute
DX0366	ICD-1366	Sepsis	Infectious
DX0367	ICD-1367	Cancer	Infectious
DX0368	ICD-1368	Gastritis	Non-communicable
DX0369	ICD-1369	Appendicitis	Non-communicable
DX0370	ICD-1370	Fracture	Chronic
DX0371	ICD-1371	UTI	Chronic
DX0372	ICD-1372	Influenza	Non-communicable
DX0373	ICD-1373	Sepsis	Chronic
DX0374	ICD-1374	Gastritis	Acute
DX0375	ICD-1375	Chronic Kidney Disease	Acute
DX0376	ICD-1376	Anemia	Acute
DX0377	ICD-1377	Cancer	Non-communicable
DX0378	ICD-1378	Hypertension	Non-communicable
DX0379	ICD-1379	Chronic Kidney Disease	Chronic
DX0380	ICD-1380	Cancer	Non-communicable
DX0381	ICD-1381	Pneumonia	Infectious
DX0382	ICD-1382	Dermatitis	Acute
DX0383	ICD-1383	Coronary Artery Disease	Infectious
DX0384	ICD-1384	UTI	Non-communicable
DX0385	ICD-1385	Cancer	Acute
DX0386	ICD-1386	Appendicitis	Acute
DX0387	ICD-1387	Chronic Kidney Disease	Acute
DX0388	ICD-1388	Sepsis	Non-communicable
DX0389	ICD-1389	Gastritis	Infectious
DX0390	ICD-1390	Stroke	Acute
DX0391	ICD-1391	UTI	Non-communicable
DX0392	ICD-1392	Dengue Fever	Acute
DX0393	ICD-1393	Chronic Kidney Disease	Acute
DX0394	ICD-1394	Cancer	Infectious
DX0395	ICD-1395	Coronary Artery Disease	Acute
DX0396	ICD-1396	Pneumonia	Acute
DX0397	ICD-1397	Influenza	Non-communicable
DX0398	ICD-1398	Fracture	Acute
DX0399	ICD-1399	Coronary Artery Disease	Infectious
DX0400	ICD-1400	Anemia	Non-communicable
DX0401	ICD-1401	Diabetes Mellitus	Chronic
DX0402	ICD-1402	Fracture	Non-communicable
DX0403	ICD-1403	Cancer	Non-communicable
DX0404	ICD-1404	Cancer	Infectious
DX0405	ICD-1405	Cancer	Chronic
DX0406	ICD-1406	COVID-19	Acute
DX0407	ICD-1407	Cancer	Non-communicable
DX0408	ICD-1408	Sepsis	Non-communicable
DX0409	ICD-1409	UTI	Acute
DX0410	ICD-1410	Diabetes Mellitus	Infectious
DX0411	ICD-1411	Appendicitis	Chronic
DX0412	ICD-1412	Sepsis	Infectious
DX0413	ICD-1413	Dermatitis	Non-communicable
DX0414	ICD-1414	Asthma	Non-communicable
DX0415	ICD-1415	Pneumonia	Infectious
DX0416	ICD-1416	UTI	Non-communicable
DX0417	ICD-1417	Stroke	Non-communicable
DX0418	ICD-1418	Anemia	Non-communicable
DX0419	ICD-1419	UTI	Non-communicable
DX0420	ICD-1420	Coronary Artery Disease	Acute
DX0421	ICD-1421	Anemia	Infectious
DX0422	ICD-1422	Anemia	Chronic
DX0423	ICD-1423	Pneumonia	Infectious
DX0424	ICD-1424	Appendicitis	Non-communicable
DX0425	ICD-1425	Anemia	Acute
DX0426	ICD-1426	Pneumonia	Chronic
DX0427	ICD-1427	Chronic Kidney Disease	Infectious
DX0428	ICD-1428	COVID-19	Non-communicable
DX0429	ICD-1429	Diabetes Mellitus	Acute
DX0430	ICD-1430	Stroke	Acute
DX0431	ICD-1431	Hypertension	Infectious
DX0432	ICD-1432	Influenza	Infectious
DX0433	ICD-1433	UTI	Non-communicable
DX0434	ICD-1434	Chronic Kidney Disease	Chronic
DX0435	ICD-1435	UTI	Acute
DX0436	ICD-1436	Influenza	Infectious
DX0437	ICD-1437	UTI	Acute
DX0438	ICD-1438	Stroke	Chronic
DX0439	ICD-1439	Hypertension	Infectious
DX0440	ICD-1440	Depression	Non-communicable
DX0441	ICD-1441	UTI	Acute
DX0442	ICD-1442	Stroke	Acute
DX0443	ICD-1443	Coronary Artery Disease	Acute
DX0444	ICD-1444	Fracture	Acute
DX0445	ICD-1445	Stroke	Chronic
DX0446	ICD-1446	Appendicitis	Acute
DX0447	ICD-1447	Cancer	Infectious
DX0448	ICD-1448	Pneumonia	Acute
DX0449	ICD-1449	Fracture	Non-communicable
DX0450	ICD-1450	Migraine	Non-communicable
DX0451	ICD-1451	Influenza	Infectious
DX0452	ICD-1452	Pneumonia	Infectious
DX0453	ICD-1453	Pneumonia	Acute
DX0454	ICD-1454	Dengue Fever	Infectious
DX0455	ICD-1455	Influenza	Acute
DX0456	ICD-1456	Influenza	Non-communicable
DX0457	ICD-1457	Pneumonia	Non-communicable
DX0458	ICD-1458	Chronic Kidney Disease	Acute
DX0459	ICD-1459	Stroke	Chronic
DX0460	ICD-1460	COVID-19	Non-communicable
DX0461	ICD-1461	Appendicitis	Chronic
DX0462	ICD-1462	Diabetes Mellitus	Non-communicable
DX0463	ICD-1463	Depression	Acute
DX0464	ICD-1464	Stroke	Acute
DX0465	ICD-1465	Gastritis	Chronic
DX0466	ICD-1466	Influenza	Acute
DX0467	ICD-1467	Gastritis	Non-communicable
DX0468	ICD-1468	UTI	Chronic
DX0469	ICD-1469	COVID-19	Non-communicable
DX0470	ICD-1470	Anemia	Non-communicable
DX0471	ICD-1471	Pneumonia	Non-communicable
DX0472	ICD-1472	Coronary Artery Disease	Non-communicable
DX0473	ICD-1473	UTI	Infectious
DX0474	ICD-1474	Fracture	Infectious
DX0475	ICD-1475	UTI	Non-communicable
DX0476	ICD-1476	Migraine	Infectious
DX0477	ICD-1477	Cancer	Acute
DX0478	ICD-1478	Coronary Artery Disease	Infectious
DX0479	ICD-1479	Coronary Artery Disease	Chronic
DX0480	ICD-1480	COVID-19	Non-communicable
DX0481	ICD-1481	Asthma	Acute
DX0482	ICD-1482	Asthma	Acute
DX0483	ICD-1483	Diabetes Mellitus	Acute
DX0484	ICD-1484	Anemia	Infectious
DX0485	ICD-1485	Influenza	Infectious
DX0486	ICD-1486	Hypertension	Infectious
DX0487	ICD-1487	Sepsis	Infectious
DX0488	ICD-1488	Dermatitis	Chronic
DX0489	ICD-1489	Sepsis	Non-communicable
DX0490	ICD-1490	COVID-19	Acute
DX0491	ICD-1491	UTI	Infectious
DX0492	ICD-1492	Diabetes Mellitus	Acute
DX0493	ICD-1493	Coronary Artery Disease	Non-communicable
DX0494	ICD-1494	Appendicitis	Non-communicable
DX0495	ICD-1495	Diabetes Mellitus	Chronic
DX0496	ICD-1496	Fracture	Acute
DX0497	ICD-1497	Anemia	Acute
DX0498	ICD-1498	Appendicitis	Chronic
DX0499	ICD-1499	Fracture	Non-communicable
DX0500	ICD-1500	Fracture	Non-communicable
DX0501	ICD-1501	Stroke	Acute
DX0502	ICD-1502	Chronic Kidney Disease	Non-communicable
DX0503	ICD-1503	Sepsis	Chronic
DX0504	ICD-1504	COVID-19	Chronic
DX0505	ICD-1505	Asthma	Infectious
DX0506	ICD-1506	Influenza	Chronic
DX0507	ICD-1507	UTI	Acute
DX0508	ICD-1508	Anemia	Chronic
DX0509	ICD-1509	UTI	Chronic
DX0510	ICD-1510	Appendicitis	Non-communicable
DX0511	ICD-1511	Asthma	Non-communicable
DX0512	ICD-1512	Hypertension	Infectious
DX0513	ICD-1513	COVID-19	Infectious
DX0514	ICD-1514	Sepsis	Infectious
DX0515	ICD-1515	Pneumonia	Infectious
DX0516	ICD-1516	Hypertension	Acute
DX0517	ICD-1517	Diabetes Mellitus	Acute
DX0518	ICD-1518	Diabetes Mellitus	Chronic
DX0519	ICD-1519	Sepsis	Chronic
DX0520	ICD-1520	Hypertension	Infectious
DX0521	ICD-1521	Cancer	Acute
DX0522	ICD-1522	Sepsis	Acute
DX0523	ICD-1523	Dermatitis	Infectious
DX0524	ICD-1524	Fracture	Non-communicable
DX0525	ICD-1525	Anemia	Non-communicable
DX0526	ICD-1526	Hypertension	Infectious
DX0527	ICD-1527	Migraine	Acute
DX0528	ICD-1528	Coronary Artery Disease	Acute
DX0529	ICD-1529	Sepsis	Non-communicable
DX0530	ICD-1530	Influenza	Infectious
DX0531	ICD-1531	Migraine	Acute
DX0532	ICD-1532	Dermatitis	Acute
DX0533	ICD-1533	Asthma	Chronic
DX0534	ICD-1534	Cancer	Acute
DX0535	ICD-1535	Migraine	Acute
DX0536	ICD-1536	Chronic Kidney Disease	Acute
DX0537	ICD-1537	Sepsis	Acute
DX0538	ICD-1538	Depression	Acute
DX0539	ICD-1539	Fracture	Acute
DX0540	ICD-1540	UTI	Acute
DX0541	ICD-1541	Hypertension	Chronic
DX0542	ICD-1542	COVID-19	Infectious
DX0543	ICD-1543	Hypertension	Non-communicable
DX0544	ICD-1544	UTI	Chronic
DX0545	ICD-1545	Dermatitis	Acute
DX0546	ICD-1546	Cancer	Chronic
DX0547	ICD-1547	Anemia	Non-communicable
DX0548	ICD-1548	Sepsis	Acute
DX0549	ICD-1549	Diabetes Mellitus	Non-communicable
DX0550	ICD-1550	Dermatitis	Chronic
DX0551	ICD-1551	Dengue Fever	Infectious
DX0552	ICD-1552	Dengue Fever	Infectious
DX0553	ICD-1553	Chronic Kidney Disease	Acute
DX0554	ICD-1554	Fracture	Chronic
DX0555	ICD-1555	Anemia	Acute
DX0556	ICD-1556	COVID-19	Non-communicable
DX0557	ICD-1557	Migraine	Non-communicable
DX0558	ICD-1558	Dengue Fever	Non-communicable
DX0559	ICD-1559	Dengue Fever	Non-communicable
DX0560	ICD-1560	Dengue Fever	Infectious
DX0561	ICD-1561	Coronary Artery Disease	Non-communicable
DX0562	ICD-1562	Dengue Fever	Chronic
DX0563	ICD-1563	COVID-19	Chronic
DX0564	ICD-1564	Cancer	Acute
DX0565	ICD-1565	UTI	Infectious
DX0566	ICD-1566	Fracture	Infectious
DX0567	ICD-1567	Coronary Artery Disease	Non-communicable
DX0568	ICD-1568	Pneumonia	Chronic
DX0569	ICD-1569	Stroke	Chronic
DX0570	ICD-1570	Chronic Kidney Disease	Chronic
DX0571	ICD-1571	Influenza	Chronic
DX0572	ICD-1572	Influenza	Acute
DX0573	ICD-1573	Influenza	Infectious
DX0574	ICD-1574	Sepsis	Acute
DX0575	ICD-1575	Fracture	Acute
DX0576	ICD-1576	Appendicitis	Chronic
DX0577	ICD-1577	Cancer	Infectious
DX0578	ICD-1578	Diabetes Mellitus	Non-communicable
DX0579	ICD-1579	Gastritis	Chronic
DX0580	ICD-1580	Diabetes Mellitus	Non-communicable
DX0581	ICD-1581	Depression	Acute
DX0582	ICD-1582	Sepsis	Acute
DX0583	ICD-1583	Asthma	Acute
DX0584	ICD-1584	UTI	Chronic
DX0585	ICD-1585	Coronary Artery Disease	Non-communicable
DX0586	ICD-1586	UTI	Infectious
DX0587	ICD-1587	Diabetes Mellitus	Infectious
DX0588	ICD-1588	UTI	Chronic
DX0589	ICD-1589	Anemia	Acute
DX0590	ICD-1590	Sepsis	Chronic
DX0591	ICD-1591	UTI	Acute
DX0592	ICD-1592	Diabetes Mellitus	Acute
DX0593	ICD-1593	Diabetes Mellitus	Infectious
DX0594	ICD-1594	Coronary Artery Disease	Acute
DX0595	ICD-1595	Hypertension	Acute
DX0596	ICD-1596	Dengue Fever	Acute
DX0597	ICD-1597	UTI	Acute
DX0598	ICD-1598	Cancer	Non-communicable
DX0599	ICD-1599	Diabetes Mellitus	Acute
DX0600	ICD-1600	Influenza	Acute
\.


--
-- TOC entry 3684 (class 0 OID 16526)
-- Dependencies: 225
-- Data for Name: stg_doctors; Type: TABLE DATA; Schema: public; Owner: postgres
--

