alter table OA_THEMEOPTION add OPTIONSCORE_BACK Numeric(7,3);
go
UPDATE OA_THEMEOPTION SET OPTIONSCORE_BACK = OPTIONSCORE ;
go
update OA_THEMEOPTION set OPTIONSCORE = null;
go
alter table OA_THEMEOPTION alter COLUMN  OPTIONSCORE Numeric(7,3);
go
UPDATE OA_THEMEOPTION SET OPTIONSCORE = OPTIONSCORE_BACK ;
go
alter table OA_THEMEOPTION drop column OPTIONSCORE_BACK;
go
alter table oa_mailinterior add cloudcontrol numeric(1,0);
go
update ez_form set editorType=1 where editorType is null or editorType='';
go


create table gov_pdffilename ( pdfid       numeric(20) identity(1,1),
  workid      numeric(20),
  pdfpzr      nvarchar(200),
  pdfpzsj     datetime,
  pdfpzhj     nvarchar(200),
  pdfzhxgsj   datetime,
  pdfrealname nvarchar(500),
  pdfsavename nvarchar(500),
  pdfgwlx     nvarchar(5),
  pdfsfpz     nvarchar(5),
  pdfwjjmc    nvarchar(100),
  recordid    numeric(20)
);
go
alter table OA_THEMEOPTION  add opImgRealName nvarchar(200) ;
go

alter table OA_THEMEOPTION  add opImgSaveName nvarchar(200) ;
go

alter table OA_THEMEOPTION  add customAnswer nvarchar(500) ;
go

create table oa_attendance_source  (
   source_id             Numeric(20)         not null,
   source_name           nvarchar(100), 
   primary key(source_id)
);
go

insert into oa_attendance_source values(1,'evo客户端');
go
insert into oa_attendance_source values(2,'微信企业号');
go

alter table WX_WORK_ATTENDANCE add attendancesource Numeric(5);
go
alter table Wx_Work_Attendance_Address add picture nvarchar(200);
go
alter table Wx_Work_Attendance_Address add remark nvarchar(500);
go

alter table Wx_Work_Attendance_Address alter column picture nvarchar(1000);
go

insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.01_SP_20160813','11.5.0.01',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.02_SP_20160817','11.5.0.02',getdate());
go





insert into ez_secu_pagelist (secu_url, client_url, list_type, createtime) values ('/modules/subsidiary/ezcard/ordersIfExistResult.jsp', '', 1, getdate());
go
insert into ez_secu_pagelist (secu_url, client_url, list_type, createtime) values ('/modules/subsidiary/ezcard/ordersIfExistResult.jsp', '', 3, getdate());
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.03_SP_20160827','11.5.0.03',getdate());
go






alter table union_task alter column REMIDTYPE VARCHAR(200);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.04_SP_20160911','11.5.0.04',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.05_SP_20160914','11.5.0.05',getdate());
go





alter table Oa_Custmenu_Qlcase alter column  QL_FIELD nvarchar(4000)
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.06_SP_20160924','11.5.0.06',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.07_SP_20160926','11.5.0.07',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.08_SP_20160928','11.5.0.08',getdate());
go




update org_right set domain_id=-1 where righttype = '定位服务-定位白名单' or righttype='定位服务-考勤签到' or righttype='定位服务-人员轨迹'
or righttype='定位服务-人员位置';
go

update Oa_Custmenu set righturlset='WXLocationAction!myWxLocationList.action' where menu_name='定位';
go

create table  EZ_BPMPOOL_OUTDATASOURCE(
       OUTDATASOURCE_ID      NUMERIC(20,0) not null  identity(1,1),
       OUTDATASOURCE_CODE    VARCHAR(100),
       OUTDATASOURCE_TYPE    VARCHAR(100),
       OUTDATASOURCE_SQL     TEXT,
       OUTDATASOURCE_FIELDS  TEXT,
       PROCESSID             VARCHAR(100),
       TASKID                VARCHAR(100),
       ISPROCESSSET          NUMERIC(1,0),
       primary key(OUTDATASOURCE_ID)
);
go

update oa_attendance_source set source_name='客户端' where source_id=1;
go
update oa_attendance_source set source_name='企业号' where source_id=2;
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.09_SP_20161015','11.5.0.09',getdate());
go






ALTER TABLE  ORG_ORGANIZATION  ADD   ONELEVEL_USERID  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   ONELEVEL_USERNAME  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   TWOLEVEL_USERID  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   TWOLEVEL_USERNAME  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   THREELEVEL_USERID  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   THREELEVEL_USERNAME  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   FOURLEVEL_USERID  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   FOURLEVEL_USERNAME  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   FIVELEVEL_USERID  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   FIVELEVEL_USERNAME  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   SIXLEVEL_USERID  NVARCHAR(200)
GO
ALTER TABLE  ORG_ORGANIZATION  ADD   SIXLEVEL_USERNAME  NVARCHAR(200)
GO
alter table GOV_receiveFile add  receiveFile_SENDFILEUNITID  nvarchar(200);
go
alter table oa_boardroom add ezflowApproval nvarchar(1);
go
alter table tfield add field_signpic nvarchar(1);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.10_SP_20161029','11.5.0.10',getdate());
go






alter table gov_ReceiveFileSeq  add  tempProceID nvarchar(2000);
go
update gov_ReceiveFileSeq set tempProceID=seqproceid;
go
alter table gov_ReceiveFileSeq drop COLUMN seqproceid ;
go
alter  table  gov_ReceiveFileSeq  add  seqproceid nvarchar(2000);
go
update gov_ReceiveFileSeq set seqproceid='$'+tempProceID+'$';
go
alter table gov_ReceiveFileSeq  alter   COLUMN seqprocenamer nvarchar(2000);
alter table gov_ReceiveFileSeq drop COLUMN tempProceID;
go

alter table OA_INFORMATIONHISTORY alter column HISTORYISSUERNAME  nvarchar(100);
alter table OA_INFORMATIONBROWSER alter column BROWSERNAME  nvarchar(100);
alter table OA_INFORMATIONVIEWRECORD alter column VIEWERNAME  nvarchar(100);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.11_SP_20161105','11.5.0.11',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.12_SP_20161110','11.5.0.12',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.13_SP_20161113','11.5.0.13',getdate());
go






alter table   ez_flow_hi_procinst  add  WHIR_FROMTASKID nvarchar(300);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.14_SP_20161128','11.5.0.14',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.15_SP_20161203','11.5.0.15',getdate());
go






 update org_organization set onelevel_userid = '$'+onelevel_userid+'$'
 where onelevel_userid<>'' and onelevel_userid is not null;
 go
 update org_organization set onelevel_username = onelevel_username+','
 where onelevel_username<>'' and onelevel_username is not null ;
 go
 update org_organization set twolevel_userid = '$'+twolevel_userid+'$'
 where twolevel_userid<>'' and twolevel_userid is not null;
 go
 update org_organization set twolevel_username = twolevel_username+','
 where twolevel_username<>'' and twolevel_username is not null;
 go
 update org_organization set threelevel_userid = '$'+threelevel_userid+'$'
 where threelevel_userid<>'' and threelevel_userid is not null;
 go
 update org_organization set threelevel_username = threelevel_username+','
 where threelevel_username<>'' and threelevel_username is not null;
 go
 update org_organization set fourlevel_userid = '$'+fourlevel_userid+'$'
 where fourlevel_userid<>'' and fourlevel_userid is not null;
 go
 update org_organization set fourlevel_username = fourlevel_username+','
 where fourlevel_username<>'' and fourlevel_username is not null;
 go
 update org_organization set fivelevel_userid = '$'+fivelevel_userid+'$'
 where fivelevel_userid<>'' and fivelevel_userid is not null;
 go
 update org_organization set fivelevel_username = fivelevel_username+','
 where fivelevel_username<>'' and fivelevel_username is not null;
 go
 update org_organization set sixlevel_userid = '$'+sixlevel_userid+'$'
 where sixlevel_userid<>'' and sixlevel_userid is not null;
 go
 update org_organization set sixlevel_username = sixlevel_username+','
 where sixlevel_username<>'' and sixlevel_username is not null; 
 go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.16_SP_20161219','11.5.0.16',getdate());
go







-- 初始化流程场景portlet
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
   '流程场景',
   null,
   'processscene',
   '',
   '',
   '1',
   null,
   163,
   '0',
   0,
   '',
   'cate_dealwith',
   '文件办理类',
   30,
   'fa-sitemap');
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.17_SP_20170103','11.5.0.17',getdate());
go






update tfield set field_name = 'boardroomId' where field_code='boardroomid';
go
update wf_oa_relatefield set field_table_displayname = '人员表(系统)' where field_table_displayname='人员表(系统))';
go
insert into  EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE)values('/OpenFromMobile',1);
go
insert into  EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE)values('/OpenFromMobile',3);
go
update oa_custmenu set MENULEVELSet=1,MENU_SCOPE='0'where MENU_NAME='资产管理';
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.18_SP_20170313','11.5.0.18',getdate());
go







insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.19_SP_20170324','11.5.0.19',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.20_SP_20170414','11.5.0.20',getdate());
go







insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.21_SP_20170508','11.5.0.21',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.22_SP_20170511','11.5.0.22',getdate());
go







--系统设置：word编辑增加选人范围--
alter table org_domain add  evoWordRangeIds text;
go
alter table org_domain add  evoWordRangeNames text;
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.23_SP_20170515','11.5.0.23',getdate());
go







alter  table  ez_flow_hi_procinst  alter column WHIR_DEALING_USERS   NVARCHAR(4000);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.5.0.24_SP_20170610','11.5.0.24',getdate());
go