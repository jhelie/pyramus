insert into 
  ContactInfo (id, additionalInfo, version)
values   
  (11, 'For student test', 1),
  (12, 'For Tanya tester', 1);
  
SET foreign_key_checks = 0;

insert into 
  Person (id, version, birthday, sex, socialSecurityNumber, basicInfo, secureInfo, defaultUser_id)
values 
  (9, 1, PARSEDATETIME('1 1 1980', 'd M yyyy'), 'FEMALE', '123412-6789', 'Test student', false, 9),
  (10, 1, PARSEDATETIME('1 1 1983', 'd M yyyy'), 'FEMALE', '123413-5789', 'Test student', false, 10);
  
insert into
  User (id, person_id, firstName, lastName, contactInfo, version)
values 
  (9, 9, 'Tester', 'Studentor', 11, 1),
  (10, 10, 'Tanya', 'Testari', 12, 1);

insert into
  StaffMember (id, role, title)
values 
  (9, 'STUDENT', null),
  (10, 'STUDENT', null);

insert into StudentGroupStudent
  (id, studentGroup, student, version)
values 
  (1, 1, 10, 1);  
  
insert into 
  Student (id, studyProgramme, nickname, previousStudies, studyStartDate, 
    additionalInfo, activityType, educationalLevel, language, municipality, nationality, school, 
    examinationType, education, lodging, archived)
values 
  (10, 1, 'Tanya-T', 0, PARSEDATETIME('1 1 2010', 'd M yyyy'), 'Testing #1', 1, 1, 1, 1, 1, 1, 1, 'Education #1', false, false);

SET foreign_key_checks = 1;

insert into 
  Address (id, city, country, postalCode, streetAddress, name, contactInfo, contactType, indexColumn, defaultAddress, version)
values 
  (3, 'Southshire', 'Yemen', '17298', '6967 Bailee Mission', null, 11, 1, 0, true, 1),
  (4, 'Horzire', 'Yeamen', '17298', '6967 Bailee Mission', null, 12, 1, 0, true, 1);
  
insert into 
  Email (id, address, defaultAddress, contactInfo, contactType, indexColumn, version)
values 
  (3, 'student1@bogusmail.com', true, 11, 1, 0, 1),
  (4, 'student2@bogusmail.com', true, 12, 1, 0, 1);
  
insert into 
  PhoneNumber (id, number, defaultNumber, contactInfo, contactType, indexColumn, version)
values 
  (3, '+456 78 901 2345', true, 11, 1, 0, 1),
  (4, '+456 78 901 2222', true, 12, 1, 0, 1);
  
insert into 
  ContactURL (id, url, contactInfo, contactURLType, indexColumn, version)
values 
  (3, 'http://www.student1webpage.com', 11, 1, 0, 1),
  (4, 'http://www.student1webpage.com', 12, 1, 0, 1);
  
delete from hibernate_sequences where sequence_name in ('ContactInfo', 'Person', 'User', 'StaffMember', 'Address', 'Email', 'PhoneNumber', 'ContactURL', 'Student', 'StudentGroupStudent');

insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'ContactInfo', max(id) + 1 from ContactInfo;
insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'Person', max(id) + 1 from Person;
insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'User', max(id) + 1 from User;
insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'StaffMember', max(id) + 1 from StaffMember;
insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'Address', max(id) + 1 from Address;
insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'Email', max(id) + 1 from Email;
insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'PhoneNumber', max(id) + 1 from PhoneNumber;
insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'ContactURL', max(id) + 1 from ContactURL;
insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'Student', max(id) + 1 from Student;
insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'StudentGroupStudent', max(id) + 1 from StudentGroupStudent;