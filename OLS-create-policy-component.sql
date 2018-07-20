--Tạo policy
EXECUTE SA_SYSDBA.CREATE_POLICY('ACCESS_PROJECT', 'OLS_PROJECT');


--Tạo user QLDA để quản lý policy này
create user QLDA identified by huyha default tablespace users temporary tablespace temp;

--Grant role ACCESS_PROJECT_DBA cho user QLDA
GRANT ACCESS_DUAN_DBA TO QLDA;

-- Grant quyền tạo ra các thành phần của label
GRANT EXECUTE ON SA_COMPONENTS TO QLDA;

-- Grant quyền tạo các label
GRANT EXECUTE ON SA_LABEL_ADMIN TO QLDA;

-- Grant quyền gán policy cho các bảng
GRANT EXECUTE ON SA_POLICY_ADMIN TO QLDA;

--Grant quyền gán label cho tài khoản
GRANT EXECUTE ON SA_USER_ADMIN TO QLDA;

--Chuyển chuỗi thành số của label
GRANT EXECUTE ON CHAR_TO_LABEL TO QLDA;

--Grant session cho QLDA
grant create session to QLDA;

--Tạo các thành phần level cho chính sách ACCESS_PROJECT
EXEC SA_COMPONENTS.CREATE_LEVEL('ACCESS_PROJECT', 9000, 'HSR', 'High Secret');
EXEC SA_COMPONENTS.CREATE_LEVEL('ACCESS_PROJECT', 8000, 'SCR', 'Secret');
EXEC SA_COMPONENTS.CREATE_LEVEL('ACCESS_PROJECT', 7000, 'LMT', 'Limitation');
EXEC SA_COMPONENTS.CREATE_LEVEL('ACCESS_PROJECT', 6000, 'RGL', 'Regular');

--Tạo compartment
EXEC SA_COMPONENTS.CREATE_COMPARTMENT('ACCESS_PROJECT', 3000, 'PSL', 'personnel');
EXEC SA_COMPONENTS.CREATE_COMPARTMENT('ACCESS_PROJECT', 2000, 'ACT', 'Accountant');
EXEC SA_COMPONENTS.CREATE_COMPARTMENT('ACCESS_PROJECT', 1000, 'PLN', 'Plan');

--Tạo group
EXEC SA_COMPONENTS.CREATE_GROUP('ACCESS_PROJECT', 1, 'CT', 'Công Ty', NULL);
EXEC SA_COMPONENTS.CREATE_GROUP('ACCESS_PROJECT', 2, 'CTH', 'Cần Thơ', 'CT');
EXEC SA_COMPONENTS.CREATE_GROUP('ACCESS_PROJECT', 3, 'DN', 'Đà Nẵng', 'CT');
EXEC SA_COMPONENTS.CREATE_GROUP('ACCESS_PROJECT', 4, 'HCM', 'Hồ Chí Minh', 'CT');
EXEC SA_COMPONENTS.CREATE_GROUP('ACCESS_PROJECT', 5, 'HN', 'Hà Nội', 'CT');
EXEC SA_COMPONENTS.CREATE_GROUP('ACCESS_PROJECT', 6, 'HP', 'Hải Phòng', 'CT');

--Tạo Label
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 2000, 'LMT:PSL:HCM');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 1800, 'LMT:PSL:HN');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 1600, 'LMT:PSL:DN');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 1400, 'LMT:PSL:HP');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 1200, 'LMT:PSL:CTH');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 1000, 'LMT:ACT:HCM');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 900, 'LMT:ACT:HN');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 800, 'LMT:ACT:DN');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 700, 'LMT:ACT:HP');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 600, 'LMT:ACT:CTH');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 500, 'LMT:PLN:HCM');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 400, 'LMT:PLN:HN');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 300, 'LMT:PLN:DN');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 200, 'LMT:PLN:HP');
EXEC SA_LABEL_ADMIN.CREATE_LABEL('ACCESS_PROJECT', 100, 'LMT:PLN:CTH');

--Gán chính sách cho bảng PRoject
EXEC SA_POLICY_ADMIN.APPLY_TABLE_POLICY('ACCESS_PROJECT', 'OwnerDB', 'Project', 'NO_CONTROL');

--Gán quyền cho QLDA
GRANT SELECT, INSERT, UPDATE ON OwnerDB.Project TO QLDA;
