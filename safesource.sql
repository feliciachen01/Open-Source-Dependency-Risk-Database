-- Used bookbiz.sql as a reference for the creation of this file
-- date attributes may have to be changed due to naming conflicts?
-- ON UPDATE CASCADE is not natively supported by Oracle, we will provide alternatives

create table software
    (projectID int,
    name varchar(1024) not null,
    description varchar(1024),
    repoURL varchar(1024) not null unique,
    author varchar(1024) not null,
    primary key (projectID));

grant select on software to public;

create table audits
    (auditID int,
    projectID int,
    date date not null,
    primary key (auditID),
    foreign key (projectID) references software
    ON DELETE CASCADE);

grant select on audits to public;

create table auditevent
    (projectID int,
    date date not null,
    type varchar(1024) not null,
    conductedBy varchar(1024) not null,
    primary key (projectID, date),
    foreign key (projectID) references software
    ON DELETE CASCADE);

grant select on auditevent to public;

create table packages
    (packageID int,
    name varchar(1024) not null,
    sourceReg varchar(1024) not null,
    maintainerOrg varchar(1024) not null,
    primary key (packageID));

grant select on packages to public;

create table packageversion
    (packageID int,
    version int,
    releaseDate date not null,
    primary key (packageID, version),
    foreign key (packageID) references packages
    ON DELETE CASCADE);

grant select on packageversion to public;

create table finding
    (findingID int,
    auditID int,
    type varchar(1024) not null,
    description varchar(1024) not null,
    packageID int,
    version int,
    primary key (findingID),
    foreign key (auditID) references audits ON DELETE CASCADE,
    foreign key (packageID, version) references packageversion ON DELETE CASCADE);

grant select on finding to public;

create table findingseverity
    (auditID int,
    packageID int,
    version int,
    severity int not null,
    type varchar(1024) not null,
    primary key (auditID, packageID, version, type),
    foreign key (auditID) references audits ON DELETE CASCADE,
    foreign key (packageID, version) references packageversion ON DELETE CASCADE);

grant select on findingseverity to public;

create table securityrisk
    (findingID int,
    vulnerabilityID int not null,
    CVSSscore decimal(3,1) not null,
    primary key (findingID),
    foreign key (findingID) references finding 
    ON DELETE CASCADE);

grant select on securityrisk to public;

create table licenserisk
    (findingID int,
    obligationType int not null,
    complianceImpact varchar(1024) not null,
    primary key (findingID),
    foreign key (findingID) references finding
    ON DELETE CASCADE);

grant select on licenserisk to public;

create table remediation
    (remediationID int,
    findingID int,
    actionType varchar(1024) not null,
    actionDate date not null,
    status int not null,
    primary key (remediationID),
    foreign key (findingID) references finding
    ON DELETE CASCADE);

grant select on remediation to public;

create table dependson
    (projectID int,
    version int,
    packageID int,
    primary key (projectID, version, packageID),
    foreign key (projectID) references software ON DELETE CASCADE,
    foreign key (packageID, version) references packageversion ON DELETE CASCADE);

grant select on dependson to public;

create table license
    (licenseID int,
    name varchar(1024) not null,
    type varchar(1024) not null,
    requiresAttribution boolean not null, -- boolean may or may not be supported depending on UBC provided oracle version. 23c supports boolean
    primary key (licenseID));

grant select on license to public;

create table uses
    (licenseID int,
    version int,
    packageID int,
    primary key (licenseID, version, packageID),
    foreign key (licenseID) references license ON DELETE CASCADE,
    foreign key (packageID, version) references packageversion ON DELETE CASCADE);

grant select on uses to public;

create table users -- user is apparently a reserved keyword in oracle
    (userID int,
    name varchar(1024) not null,
    email varchar(1024) not null unique,
    phoneNum varchar(1024) not null,
    primary key (userID));

grant select on users to public;

create table interacts
    (userID int,
    projectID int,
    permissions varchar(1024) not null,
    primary key (userID, projectID),
    foreign key (userID) references users ON DELETE CASCADE,
    foreign key (projectID) references software ON DELETE CASCADE);

grant select on interacts to public;

insert into software
values(1, 'OpenTrack', 'Project tracking tool', 'https://github.com/org/opentrack', 'Alice Smith');

insert into software
values(2, 'SecureScan', 'Security scanning tool', 'https://github.com/org/securescan', 'Bob Jones');

insert into software
values(3, 'DataVault', 'Data encryption service', 'https://github.com/org/datavault', 'Carol White');

insert into software
values(4, 'LogWatch', 'Log monitoring tool', 'https://github.com/org/logwatch', 'Dave Brown');

insert into software
values(5, 'NetGuard', 'Network security tool', 'https://github.com/org/netguard', 'Eve Davis');

insert into audits
values(1, 1, DATE '2024-01-15');

insert into audits
values(2, 2, DATE '2024-02-20');

insert into audits
values(3, 3, DATE '2024-03-10');

insert into audits
values(4, 4, DATE '2024-04-05');

insert into audits
values(5, 5, DATE '2024-05-18');

insert into auditevent
values(1, DATE '2024-01-15', 'Security Review', 'Alice Smith');

insert into auditevent
values(2, DATE '2024-02-20', 'License Check', 'Bob Jones');

insert into auditevent
values(3, DATE '2024-03-10', 'Dependency Audit', 'Carol White');

insert into auditevent
values(4, DATE '2024-04-05', 'Compliance Review', 'Dave Brown');

insert into auditevent
values(5, DATE '2024-05-18', 'Vulnerability Scan', 'Eve Davis');

insert into packages
values(1, 'lodash', 'npmjs.com', 'Lodash Org');

insert into packages
values(2, 'express', 'npmjs.com', 'Express Team');

insert into packages
values(3, 'numpy', 'pypi.org', 'NumPy Org');

insert into packages
values(4, 'openssl', 'openssl.org', 'OpenSSL Foundation');

insert into packages
values(5, 'log4j', 'maven.org', 'Apache Foundation');

insert into packageversion
values(1, 1, DATE '2023-01-10');

insert into packageversion
values(2, 1, DATE '2023-03-15');

insert into packageversion
values(3, 1, DATE '2023-05-20');

insert into packageversion
values(4, 1, DATE '2023-07-25');

insert into packageversion
values(5, 1, DATE '2023-09-30');

insert into finding
values(1, 1, 'Security', 'SQL injection vulnerability', 1, 1);

insert into finding
values(2, 2, 'License', 'GPL license conflict', 2, 1);

insert into finding
values(3, 3, 'Security', 'Buffer overflow risk', 3, 1);

insert into finding
values(4, 4, 'Compliance', 'Missing attribution', 4, 1);

insert into finding
values(5, 5, 'Security', 'CVE-2021-44228 log4shell', 5, 1);

insert into findingseverity
values(1, 1, 1, 9, 'Security');

insert into findingseverity
values(2, 2, 1, 5, 'License');

insert into findingseverity
values(3, 3, 1, 8, 'Security');

insert into findingseverity
values(4, 4, 1, 3, 'Compliance');

insert into findingseverity
values(5, 5, 1, 10, 'Security');

insert into securityrisk
values(1, 20240001, 9.8);

insert into securityrisk
values(3, 20240002, 8.5);

insert into securityrisk
values(5, 20210001, 10.0);

insert into securityrisk
values(2, 20240003, 6.2);

insert into securityrisk
values(4, 20240004, 5.5);

insert into licenserisk
values(2, 1, 'Must open source derivatives');

insert into licenserisk
values(4, 2, 'Attribution required in documentation');

insert into licenserisk
values(1, 3, 'Commercial use restricted');

insert into licenserisk
values(3, 4, 'Patent clause applies');

insert into licenserisk
values(5, 5, 'Distribution limitations apply');

insert into remediation
values(1, 1, 'Patch', DATE '2024-02-01', 1);

insert into remediation
values(2, 2, 'Replace Package', DATE '2024-03-01', 0);

insert into remediation
values(3, 3, 'Upgrade', DATE '2024-04-01', 1);

insert into remediation
values(4, 4, 'Add Attribution', DATE '2024-04-15', 1);

insert into remediation
values(5, 5, 'Emergency Patch', DATE '2024-05-01', 1);

insert into dependson
values(1, 1, 1);

insert into dependson
values(2, 1, 2);

insert into dependson
values(3, 1, 3);

insert into dependson
values(4, 1, 4);

insert into dependson
values(5, 1, 5);

insert into license
values(1, 'MIT License', 'Permissive', true);

insert into license
values(2, 'GPL v3', 'Copyleft', true);

insert into license
values(3, 'Apache 2.0', 'Permissive', true);

insert into license
values(4, 'BSD 2-Clause', 'Permissive', true);

insert into license
values(5, 'LGPL v2', 'Copyleft', false);

insert into uses
values(1, 1, 1);

insert into uses
values(2, 1, 2);

insert into uses
values(3, 1, 3);

insert into uses
values(4, 1, 4);

insert into uses
values(5, 1, 5);

insert into users
values(1, 'Alice Smith', 'alice@example.com', '604-111-2222');

insert into users
values(2, 'Bob Jones', 'bob@example.com', '604-333-4444');

insert into users
values(3, 'Carol White', 'carol@example.com', '604-555-6666');

insert into users
values(4, 'Dave Brown', 'dave@example.com', '604-777-8888');

insert into users
values(5, 'Eve Davis', 'eve@example.com', '604-999-0000');

insert into interacts
values(1, 1, 'admin');

insert into interacts
values(2, 2, 'read');

insert into interacts
values(3, 3, 'write');

insert into interacts
values(4, 4, 'read');

insert into interacts
values(5, 5, 'admin');