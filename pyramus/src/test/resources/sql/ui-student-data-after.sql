delete from ContactInfo where id = 11;

SET foreign_key_checks = 0;

delete from Person where id = 9;
  
delete from User where id = 9;
  
SET foreign_key_checks = 1;

delete from StaffMember where id = 8;
  
delete from Address where id = 3;

delete from Email where id = 3;
  
delete from PhoneNumber where id = 3;
  
delete from ContactURL where id = 3;
  
--delete from hibernate_sequences where sequence_name in ('ContactInfo', 'Person', 'User', 'StaffMember', 'Address', 'Email', 'PhoneNumber', 'ContactURL');

--insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'ContactInfo', max(id) + 1 from ContactInfo;
--insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'Person', max(id) + 1 from Person;
--insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'User', max(id) + 1 from User;
--insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'StaffMember', max(id) + 1 from StaffMember;
--insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'Address', max(id) + 1 from Address;
--insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'Email', max(id) + 1 from Email;
--insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'PhoneNumber', max(id) + 1 from PhoneNumber;
--insert into hibernate_sequences (sequence_name, sequence_next_hi_value) select 'ContactURL', max(id) + 1 from ContactURL;