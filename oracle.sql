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