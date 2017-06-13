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