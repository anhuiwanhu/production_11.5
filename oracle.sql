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
  is 'pdf批注人';
comment on column GOV_PDFFILENAME.pdfpzsj
  is 'pdf批注时间';
comment on column GOV_PDFFILENAME.pdfpzhj
  is 'pdf批注环节';
comment on column GOV_PDFFILENAME.pdfzhxgsj
  is 'pdf最后修改时间';
comment on column GOV_PDFFILENAME.pdfrealname
  is 'pdf文件名';
comment on column GOV_PDFFILENAME.pdfsavename
  is 'pdf保存名';
comment on column GOV_PDFFILENAME.pdfgwlx
  is '公文类型0收文1发文';
comment on column GOV_PDFFILENAME.pdfsfpz
  is 'pdf是否批注0否1是';
comment on column GOV_PDFFILENAME.pdfwjjmc
  is 'pdf文件夹名称';
comment on column GOV_PDFFILENAME.recordid
  is '收发文id';
commit;

alter table OA_THEMEOPTION  add customAnswer varchar2(500) ;
commit;
comment on column OA_THEMEOPTION.customAnswer   is '自定义答案';
commit;

alter table OA_THEMEOPTION  add opImgRealName varchar2(200) ;
commit;
comment on column OA_THEMEOPTION.opImgRealName   is '答案的上传图片真实名';
commit;

alter table OA_THEMEOPTION  add opImgSaveName varchar2(200) ;
commit;
comment on column OA_THEMEOPTION.opImgSaveName   is '答案的上传图片保存名';
commit;


create table oa_attendance_source  (
   source_id             NUMBER(20)         not null,
   source_name           VARCHAR2(100), 
   primary key(source_id)
);
commit;
comment on table oa_attendance_source is '考勤信息来源表';
commit;
comment on column oa_attendance_source.source_id is '来源ID';
commit;
comment on column oa_attendance_source.source_name is '来源名称';
commit;

insert into oa_attendance_source values(1,'evo客户端');
commit;
insert into oa_attendance_source values(2,'微信企业号');
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





update org_right set domain_id=-1 where righttype = '定位服务-定位白名单' or righttype='定位服务-考勤签到' or righttype='定位服务-人员轨迹'
or righttype='定位服务-人员位置';
commit;

update Oa_Custmenu set righturlset='WXLocationAction!myWxLocationList.action' where menu_name='定位';
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

update oa_attendance_source set source_name='客户端' where source_id=1;
commit;
update oa_attendance_source set source_name='企业号' where source_id=2;
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
comment on column GOV_receiveFile.receiveFile_SENDFILEUNITID is '来文单位id集合';
commit;
alter table oa_boardroom add ezflowApproval varchar2(1);
comment on column oa_boardroom.ezflowApproval is '流程审批(0 是 1 否)';
commit;
alter table tfield add field_signpic varchar2(1);
comment on column tfield.field_signpic  is '使用签名图片(1 是)';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.5.0.10_SP_20161029','11.5.0.10',sysdate);
commit;







alter  table  gov_ReceiveFileSeq  add  tempProceID nvarchar2(2000);
commit;
update gov_ReceiveFileSeq set tempProceID=seqproceid;
alter table gov_ReceiveFileSeq drop (seqproceid);
commit;

alter  table  gov_ReceiveFileSeq  add  seqproceid nvarchar2(2000);
comment on column gov_ReceiveFileSeq.seqproceid is '流程id串';
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