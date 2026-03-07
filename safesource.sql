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
    foreign key (version, packageID) references packageversion ON DELETE CASCADE);

grant select on dependson to public;

create table license
    (licenseID int,
    name varchar(1024) not null,
    type varchar(1024) not null,
    requiresAttribution boolean not null,
    primary key (licenseID));

grant select on license to public;

create table uses
    (licenseID int,
    version int,
    packageID int,
    primary key (licenseID, version, packageID),
    foreign key (licenseID) references license ON DELETE CASCADE,
    foreign key (version, packageID) references packageversion ON DELETE CASCADE);

grant select on uses to public;

create table user
    (userID int,
    name varchar(1024) not null,
    email varchar(1024) not null unique,
    phoneNum varchar(1024) not null,
    primary key (userID));

grant select on user to public;

create table interacts
    (userID int,
    projectID int,
    permissions varchar(1024) not null,
    primary key (userID, projectID),
    foreign key (userID) references user ON DELETE CASCADE,
    foreign key (projectID references software ON DELETE CASCADE));

grant select on interacts to public;