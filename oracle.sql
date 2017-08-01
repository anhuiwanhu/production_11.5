alter table OA_THEMEOPTION add OPTIONSCORE_BACK NUMBER(7,3);
commit;
UPDATE OA_THEMEOPTION SET OPTIONSCORE_BACK = CAST(OPTIONSCORE AS NUMBER(7,3));
commit;
update OA_THEMEOPTION set OPTIONSCORE = null;
commit;
alter table OA_THEMEOPTION modify(OPTIONSCORE NUMBER(7,3));
commit;
UPDATE OA_THEMEOPTION SET OPTIONSCORE = CAST(OPTIONSCORE_BACK AS NUMBER(7,3));
commit;
alter table OA_THEMEOPTION drop column OPTIONSCORE_BACK;
commit;
alter table oa_mailinterior add cloudcontrol number(1);
commit;
update ez_form set editorType=1 where editorType is null or editorType='';
commit;

create table GOV_PDFFILENAME
( pdfid       NUMBER(20),
  workid      NUMBER(20),
  pdfpzr      NVARCHAR2(200),
  pdfpzsj     DATE,
  pdfpzhj     NVARCHAR2(2000),
  pdfzhxgsj   DATE,
  pdfrealname NVARCHAR2(500),
  pdfsavename NVARCHAR2(500),
  pdfgwlx     NVARCHAR2(5),
  pdfsfpz     NVARCHAR2(5),
  pdfwjjmc    NVARCHAR2(100),
  recordid    NUMBER(20)
);
commit;
-- Add comments to the columns 
comment on column GOV_PDFFILENAME.pdfid
  is 'id';
comment on column GOV_PDFFILENAME.workid
  is 'workid';
comment on column GOV_PDFFILENAME.pdfpzr
  is 'pdf��ע��';
comment on column GOV_PDFFILENAME.pdfpzsj
  is 'pdf��עʱ��';
comment on column GOV_PDFFILENAME.pdfpzhj
  is 'pdf��ע����';
comment on column GOV_PDFFILENAME.pdfzhxgsj
  is 'pdf����޸�ʱ��';
comment on column GOV_PDFFILENAME.pdfrealname
  is 'pdf�ļ���';
comment on column GOV_PDFFILENAME.pdfsavename
  is 'pdf������';
comment on column GOV_PDFFILENAME.pdfgwlx
  is '��������0����1����';
comment on column GOV_PDFFILENAME.pdfsfpz
  is 'pdf�Ƿ���ע0��1��';
comment on column GOV_PDFFILENAME.pdfwjjmc
  is 'pdf�ļ�������';
comment on column GOV_PDFFILENAME.recordid
  is '�շ���id';
commit;

alter table OA_THEMEOPTION  add customAnswer varchar2(500) ;
commit;
comment on column OA_THEMEOPTION.customAnswer   is '�Զ����';
commit;

alter table OA_THEMEOPTION  add opImgRealName varchar2(200) ;
commit;
comment on column OA_THEMEOPTION.opImgRealName   is '�𰸵��ϴ�ͼƬ��ʵ��';
commit;

alter table OA_THEMEOPTION  add opImgSaveName varchar2(200) ;
commit;
comment on column OA_THEMEOPTION.opImgSaveName   is '�𰸵��ϴ�ͼƬ������';
commit;


create table oa_attendance_source  (
   source_id             NUMBER(20)         not null,
   source_name           VARCHAR2(100), 
   primary key(source_id)
);
commit;
comment on table oa_attendance_source is '������Ϣ��Դ��';
commit;
comment on column oa_attendance_source.source_id is '��ԴID';
commit;
comment on column oa_attendance_source.source_name is '��Դ����';
commit;

insert into oa_attendance_source values(1,'evo�ͻ���');
commit;
insert into oa_attendance_source values(2,'΢����ҵ��');
commit;

alter table WX_WORK_ATTENDANCE add attendancesource number(5);
commit;
alter table Wx_Work_Attendance_Address add picture VARCHAR2(200);
commit;
alter table Wx_Work_Attendance_Address add remark VARCHAR2(500);
commit;

alter table Wx_Work_Attendance_Address modify picture VARCHAR2(1000);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.01_SP_20160813','11.5.0.01',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.02_SP_20160817','11.5.0.02',sysdate);
commit;






alter table union_task  modify  REMIDTYPE VARCHAR2(200);
commit;
insert into ez_secu_pagelist (secu_url, client_url, list_type, createtime) values ('/modules/subsidiary/ezcard/ordersIfExistResult.jsp', '', 1, sysdate);
commit;
insert into ez_secu_pagelist (secu_url, client_url, list_type, createtime) values ('/modules/subsidiary/ezcard/ordersIfExistResult.jsp', '', 3, sysdate);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.03_SP_20160827','11.5.0.03',sysdate);
commit;





alter table union_task modify REMIDTYPE VARCHAR2(200);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.04_SP_20160911','11.5.0.04',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.05_SP_20160914','11.5.0.05',sysdate);
commit;





alter table Oa_Custmenu_Qlcase modify QL_FIELD varchar2(4000);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.06_SP_20160924','11.5.0.06',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.07_SP_20160926','11.5.0.07',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.08_SP_20160928','11.5.0.08',sysdate);
commit;





update org_right set domain_id=-1 where righttype = '��λ����-��λ������' or righttype='��λ����-����ǩ��' or righttype='��λ����-��Ա�켣'
or righttype='��λ����-��Աλ��';
commit;

update Oa_Custmenu set righturlset='WXLocationAction!myWxLocationList.action' where menu_name='��λ';
commit;

CREATE TABLE EZ_BPMPOOL_OUTDATASOURCE (	
	OUTDATASOURCE_ID        NUMBER(20,0) not null, 
	OUTDATASOURCE_CODE      VARCHAR2(100), 
	OUTDATASOURCE_TYPE      VARCHAR2(100), 
	OUTDATASOURCE_SQL       CLOB,
	OUTDATASOURCE_FIELDS    CLOB,
	PROCESSID               VARCHAR2(100), 
	TASKID                  VARCHAR2(100), 
	ISPROCESSSET            NUMBER(1,0), 
	primary key(OUTDATASOURCE_ID)
);
commit;

update oa_attendance_source set source_name='�ͻ���' where source_id=1;
commit;
update oa_attendance_source set source_name='��ҵ��' where source_id=2;
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.09_SP_20161015','11.5.0.09',sysdate);
commit;





ALTER TABLE  ORG_ORGANIZATION  ADD   ONELEVEL_USERID  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   ONELEVEL_USERNAME  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   TWOLEVEL_USERID  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   TWOLEVEL_USERNAME  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   THREELEVEL_USERID  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   THREELEVEL_USERNAME  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   FOURLEVEL_USERID  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   FOURLEVEL_USERNAME  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   FIVELEVEL_USERID  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   FIVELEVEL_USERNAME  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   SIXLEVEL_USERID  VARCHAR2(200);
COMMIT;
ALTER TABLE  ORG_ORGANIZATION  ADD   SIXLEVEL_USERNAME  VARCHAR2(200);
COMMIT;
alter  table  GOV_receiveFile  add  receiveFile_SENDFILEUNITID nvarchar2(200);
comment on column GOV_receiveFile.receiveFile_SENDFILEUNITID is '���ĵ�λid����';
commit;
alter table oa_boardroom add ezflowApproval varchar2(1);
comment on column oa_boardroom.ezflowApproval is '��������(0 �� 1 ��)';
commit;
alter table tfield add field_signpic varchar2(1);
comment on column tfield.field_signpic  is 'ʹ��ǩ��ͼƬ(1 ��)';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.10_SP_20161029','11.5.0.10',sysdate);
commit;







alter  table  gov_ReceiveFileSeq  add  tempProceID nvarchar2(2000);
commit;
update gov_ReceiveFileSeq set tempProceID=seqproceid;
alter table gov_ReceiveFileSeq drop (seqproceid);
commit;

alter  table  gov_ReceiveFileSeq  add  seqproceid nvarchar2(2000);
comment on column gov_ReceiveFileSeq.seqproceid is '����id��';
commit;
update gov_ReceiveFileSeq set seqproceid='$'||tempProceID||'$';
commit;
alter table gov_ReceiveFileSeq  modify seqprocenamer nvarchar2(2000);
alter table gov_ReceiveFileSeq drop (tempProceID);
commit;


alter table OA_INFORMATIONHISTORY modify HISTORYISSUERNAME  VARCHAR2(100);
alter table OA_INFORMATIONBROWSER modify BROWSERNAME  VARCHAR2(100);
alter table OA_INFORMATIONVIEWRECORD modify VIEWERNAME  VARCHAR2(100);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.11_SP_20161105','11.5.0.11',sysdate);
commit;






insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.12_SP_20161110','11.5.0.12',sysdate);
commit;






insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.13_SP_20161113','11.5.0.13',sysdate);
commit;






alter table   ez_flow_hi_procinst  add  WHIR_FROMTASKID varchar2(300);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.14_SP_20161128','11.5.0.14',sysdate);
commit;






alter table   ez_flow_hi_procinst  add  WHIR_FROMTASKID varchar2(300);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.15_SP_20161203','11.5.0.15',sysdate);
commit;






 update org_organization set onelevel_userid = '$'||onelevel_userid||'$'
 where onelevel_userid<>' ' and onelevel_userid is not null;
 commit;
 update org_organization set onelevel_username = onelevel_username||','
 where onelevel_username<>' ' and onelevel_username is not null ;
  commit;
 update org_organization set twolevel_userid = '$'||twolevel_userid||'$'
 where twolevel_userid<>' ' and twolevel_userid is not null;
 commit;
 update org_organization set twolevel_username = twolevel_username||','
 where twolevel_username<>' ' and twolevel_username is not null;
  commit;
 update org_organization set threelevel_userid = '$'||threelevel_userid||'$'
 where threelevel_userid<>' ' and threelevel_userid is not null;
 commit;
 update org_organization set threelevel_username = threelevel_username||','
 where threelevel_username<>' ' and threelevel_username is not null;
  commit;
 update org_organization set fourlevel_userid = '$'||fourlevel_userid||'$'
 where fourlevel_userid<>' ' and fourlevel_userid is not null;
 commit;
 update org_organization set fourlevel_username = fourlevel_username||','
 where fourlevel_username<>' ' and fourlevel_username is not null;
  commit;
 update org_organization set fivelevel_userid = '$'||fivelevel_userid||'$'
 where fivelevel_userid<>' ' and fivelevel_userid is not null;
 commit;
 update org_organization set fivelevel_username = fivelevel_username||','
 where fivelevel_username<>' ' and fivelevel_username is not null;
 commit;
 update org_organization set sixlevel_userid = '$'||sixlevel_userid||'$'
 where sixlevel_userid<>' ' and sixlevel_userid is not null;
 commit;
 update org_organization set sixlevel_username = sixlevel_username||','
 where sixlevel_username<>' ' and sixlevel_username is not null; 
 commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.16_SP_20161219','11.5.0.16',sysdate);
commit;






-- ��ʼ�����̳���portlet
insert into oa_portal_portlet
  (PORTLET_ID,
   NAME,
   CONTENT,
   TYPE_,
   LINKURL,
   ICON_CLS,
   STATUS,
   DESCRIPTION,
   SORT_NO,
   DEL_FLAG,
   DOMAIN_ID,
   OUTTER_FLAG,
   PORTLET_CATEGORY,
   PORTLET_CATEGORY_NAME,
   CATEGORY_SORTNO,
   ICON_FONT)
values
  ((select max(a.portlet_id)+1 from oa_portal_portlet a),
   '���̳���',
   null,
   'processscene',
   null,
   '',
   '1',
   null,
   163,
   '0',
   0,
   '',
   'cate_dealwith',
   '�ļ�������',
   30,
   'fa-sitemap');
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.17_SP_20170103','11.5.0.17',sysdate);
commit;






update tfield set field_name = 'boardroomId' where field_code='boardroomid';
commit;
update wf_oa_relatefield set field_table_displayname = '��Ա��(ϵͳ)' where field_table_displayname='��Ա��(ϵͳ))';
commit;
insert into  EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE)values('/OpenFromMobile',1);
commit;
insert into  EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE)values('/OpenFromMobile',3);
commit;
update oa_custmenu set MENULEVELSet=1,MENU_SCOPE='0'where MENU_NAME='�ʲ�����';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.18_SP_20170313','11.5.0.18',sysdate);
commit;








insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.19_SP_20170324','11.5.0.19',sysdate);
commit;







insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.20_SP_20170414','11.5.0.20',sysdate);
commit;






insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.21_SP_20170508','11.5.0.21',sysdate);
commit;






insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.22_SP_20170511','11.5.0.22',sysdate);
commit;







--ϵͳ���ã�word�༭����ѡ�˷�Χ--
alter table org_domain add  evoWordRangeIds clob;
commit;
alter table org_domain add  evoWordRangeNames clob;
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.23_SP_20170515','11.5.0.23',sysdate);
commit;








alter  table  ez_flow_hi_procinst  modify  WHIR_DEALING_USERS   VARCHAR2(4000);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.24_SP_20170610','11.5.0.24',sysdate);
commit;






alter table oa_boardroomapply add  formid varchar2(200);
commit;
alter table SYS_CORP_SET_APP add moduleSecret varchar2(200);
commit;
create table ezmobile_wxToken(
  id  NUMBER(20),
  corpsecret VARCHAR2(500),
  wxToken VARCHAR2(500),	
  tokenTimeStamp VARCHAR2(20)
);
commit;
comment on column ezmobile_wxToken.corpsecret is'��ҵ΢��Ӧ�ö�Ӧsecret';
commit;
comment on column ezmobile_wxToken.wxToken is'΢�����ɵ�token';
commit;
comment on column ezmobile_wxToken.tokenTimeStamp is'token���ɵ�ʱ���';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.25_SP_20170626','11.5.0.25',sysdate);
commit;







alter table OA_BOARDROOMAPPLY add  directlypublish VARCHAR2(2);
commit;
alter table OA_BOARDROOMAPPLY add  formcode VARCHAR2(50);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.26_SP_20170630','11.5.0.26',sysdate);
commit;









insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.27_SP_20170710','11.5.0.27',sysdate);
commit;








insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.28_SP_20170718','11.5.0.28',sysdate);
commit;







insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.29_SP_20170724','11.5.0.29',sysdate);
commit;









insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.30_SP_20170731','11.5.0.30',sysdate);
commit;