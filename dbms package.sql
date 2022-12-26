create table polyclinic(
                         polyclinic_name varchar(20) primary key,
                         address varchar(40),
                         timings number(10)not null,
                         phone_no number(10) not null
                         ,check(ascii(substr(polyclinic_name,1,1))between 60 and 90));

insert  into polyclinic values('Dental Polyclinic','Breach Candy',6,9876543210);

create table patient1(
                        patient_id number(7) primary key,
                        polyclinic_name varchar(20),
                        foreign key(polyclinic_name) references polyclinic(polyclinic_name),
                        patient_name varchar(20),
                        dob date not null,
                        check (patient_name like 'Mr%' or patient_name like 'Mrs%' or patient_name like 'Ms%')
                        );
insert into patient1 values(1,'Dental Polyclinic','Mr.Smith','25/03/1967');

insert into patient1 values(2,'Dental Polyclinic','Mr.Andrews','04/02/1978');

insert into patient1 values(3,'Dental Polyclinic','Mrs.Rodriguez','28/07/1987');

insert into patient1 values(4,'Dental Polyclinic','Mr.Holt','21/08/1983');

insert into patient1 values(5,'Dental Polyclinic','Ms.Ruby','16/01/1998');
select * from patient1;

create table patient2(
                    patient_id number(7),
                    foreign key(patient_id) references patient1(patient_id),
                    prev_treatment varchar(50) primary key,
                    last_date_visit date not null
                    );
insert into patient2 values(1,'Root Canal','10/10/2017');

insert into patient2 values(2,'Gums','11/12/2016');

insert into patient2 values(3,'Cavities','10/03/2018');

insert into patient2 values(4,'Missing Teeth','23/03/2018');

insert into patient2 values(5,'Mobile Teeth','25/10/2017');
select * from patient2;

create table regular_patient(
                             discount number(5),
                             patient_id number(7) ,
                             foreign key(patient_id) references patient1(patient_id)
                             );
insert into regular_patient values(null,1);

insert into regular_patient values(250,2);

insert into regular_patient values(500,3);

insert into regular_patient values(750,4);

insert into regular_patient values(null,5);

select * from regular_patient;

create table new_patient(
                        first_free_checkup varchar(10),
                        date_visit date,
                        patient_id number(7),
                        foreign key(patient_id) references patient1(patient_id),
                        check(first_free_checkup='Y'or first_free_checkup='N')
                        );
insert into new_patient values('Y','10/10/2017',1);

insert into new_patient values('N','11/12/2016',2);

insert into new_patient values('N','10/03/2018',3);

insert into new_patient values('N','23/03/2018',4);

insert into new_patient values('Y','25/10/2017',5);
select * from new_patient;


create table doc1(
                 doc_id number(7) primary key,
                 salary_slipno number(5) unique,
                 doc_name varchar(20),
                 phone_no number(10)
                 );

insert into doc1 values(100,100,'Dr. Ray',9821054690);

insert into doc1 values(200,101,'Dr. Bing',9821009751);

insert into doc1 values(300,102,'Dr. Stromberg',9143211091);

insert into doc1 values(400,103,'Dr. David',9213447010);

insert into doc1 values(500,104,'Dr. James',9900887755);

select * from doc1;


create table doc2(
                salary_slipno number(5) primary key,
                foreign key(salary_slipno) references doc1(salary_slipno),
                salary number(6)
                );

insert into doc2 values(100,500000);

insert into doc2 values(101,250200);

insert into doc2 values(102,512200);

insert into doc2 values(103,700000);

insert into doc2 values(104,656666);

select * from doc2;


create table doc3(
                doc_id number(7),
                foreign key(doc_id) references doc1(doc_id),
                dep_no number(5) ,
                dep_name varchar(20),
                check(dept_name='Endodontist' or dept_name='Periodontist'or dept_name='General Dentist')
                );

insert into doc3 values(100,1,'Endodontist');

insert into doc3 values(200,1,'Endodontist');

insert into doc3 values(300,2,'Periodontist');

insert into doc3 values(400,3,'General Dentist');

insert into doc3 values(500,3,'General Dentist');

select * from doc3;

create table endodontist(
                        doc_id number(7),
                        foreign key(doc_id) references doc1(doc_id),
                        root_canal varchar(40)
                        );

insert into endodontist values(100,'Soft tissue inflammation');

insert into endodontist values(200,'Deep decay');
select * from endodontist;

create table periodontist(
                            doc_id number(7),
                            foreign key(doc_id) references doc1(doc_id),
                            gums varchar(20)
                          );

insert into periodontist values(300,'Gum Disease');
select * from periodontist;


create table gen_dentist(
                        doc_id number(7),
                        foreign key(doc_id) references doc1(doc_id),
                        cavities varchar(20),
                        missing_teeth varchar(20),
                        mobile_teeth varchar(20)
                        );

insert into gen_dentist values(400,'Decay','Missing Teeth','Loose Teeth');

insert into gen_dentist values(500,'Decay','Missing Teeth','Loose Teeth');

select * from gen_dentist;

create table dependents(
                        depen_name varchar(10) primary key,
                        phone_no number(10),
                        patient_id number(7),
                        foreign key(patient_id) references patient1(patient_id)
                        );  

insert into dependents values('Roger',9165625400,1);

insert into dependents values('Fin',9165623880,2);

insert into dependents values('Thomas',9789879765,3);

insert into dependents values('Alfie',9914323523,4);

insert into dependents values('Arthur',9678229119,5);

select * from dependents;

create table medic_hist(
                        patient_id number(7),
                        foreign key(patient_id) references patient1(patient_id),
                        past_treatment varchar(20) primary key,
                        allergies varchar(20),
                        pain_tooth varchar(20),
                        heart_probs varchar (20),
                        other_illness varchar(20)
                        );

insert into medic_hist values(1,'Root Canal','Penicillin',null,'High BP','Diabetes');

insert into medic_hist values(2,'Cavities',null,'Upper Left Tooth',null,'Rhinitis');

insert into medic_hist values(3,'Loose Teeth','Pollen',null,'High BP','Arthritis');

insert into medic_hist values(4,'Decay','Pollen','Lower Left Side',null,null);

insert into medic_hist values(5,'Gingivitis','Lignocaine','Lower Right Side','High BP','Cardiac Problem');
select * from medic_hist;


--1 To get the Full Patient information:
select p1.patient_id, p1.patient_name, p1.dob, p2.prev_treatment, p2.last_date_visit, mh.allergies, mh.other_illness from patient1 p1, patient2 p2, medic_hist mh  where p1.patient_id = p2.patient_id and p1.patient_id = mh.patient_id;

--2 To get the Patient’s Dependents information:
select p1.patient_id, p1.patient_name, dep.depen_name, dep.phone_no from patient1 p1 inner join dependents dep on p1.patient_id = dep.patient_id;

--3 To get Full Doctor information:
select doc1.doc_id, doc1.doc_name, doc1.phone_no, doc2.salary_slipno, doc2.salary, doc3.dep_no, doc3.dep_name from doc1, doc2, doc3 where doc1.salary_slipno = doc2.salary_slipno and doc1.doc_id = doc3.doc_id;

--4  To get the Endodontist’s information:
select doc1.doc_id, doc1.doc_name,doc1.phone_no, doc2.salary_slipno, doc2.salary, endodontist.root_canal from doc1, doc2, endodontist where doc1.salary_slipno = doc2.salary_slipno and doc1.doc_id = endodontist.doc_id;

--5 To get the Periodontist’s information:
select doc1.doc_id, doc1.doc_name,doc1.phone_no, doc2.salary_slipno, doc2.salary, periodontist.gums from doc1, doc2, periodontist where doc1.salary_slipno = doc2.salary_slipno and doc1.doc_id = periodontist.doc_id;

--6 To get the General Dentist’s information:
select doc1.doc_id, doc1.doc_name, doc1.phone_no, doc2.salary_slipno, doc2.salary, gen_dentist.cavities, gen_dentist.missing_teeth, gen_dentist.mobile_teeth from doc1, doc2, gen_dentist where doc1.salary_slipno = doc2.salary_slipno and doc1.doc_id = gen_dentist.doc_id;

--7  To find out which Patients are new (which are in the first check-up free category)
select patient_id, patient_name, dob from patient1 where(patient_id) in (select patient_id from new_patient where first_free_checkup = 'Y');

--8 To find out which Patients are regular (which get a discount)
select patient_id, patient_name, dob from patient1 where(patient_id) in (select patient_id from regular_patient where discount>0);

--9 To find out which Doctor has the highest salary
select doc1.doc_id, doc1.doc_name, doc2.salary ,doc2.salary_slipno, doc3.dep_name from doc1,doc2,doc3 where doc1.salary_slipno  = doc2.salary_slipno and doc1.doc_id = doc3.doc_id order by doc2.salary desc;

--10  To find out which Regular Patients get the most discount
select patient1.patient_id, patient1.patient_name, patient2.prev_treatment, regular_patient.discount from patient1, patient2, regular_patient where patient1.patient_id = patient2.patient_id and patient1.patient_id = regular_patient.patient_id  and regular_patient.discount>0 order by regular_patient.discount desc;

--11  To find the Doctors which have salary greater than the average salary of all the Doctors.
select avg(salary) from doc2;
select doc1.doc_id ,doc1.doc_name, doc2.salary_slipno, doc2.salary from doc1,doc2 where doc1.salary_slipno = doc2.salary_slipno and  doc2.salary >= (select avg(salary) as sal from doc2) ;

--12  Use of union operator
select doc_id from endodontist union select doc_id from periodontist union select doc_id from gen_dentist;

--13 Use of intersect operator
select doc_id from endodontist intersect select doc_id from periodontist intersect select doc_id from gen_dentist;

--14  Using natural join
select patient_id, patient_name, prev_treatment, dob, last_date_visit from patient1 natural join patient2;

--15  Use of null values
select patient_id from regular_patient where discount is null;

--16 Use of minus
select patient_id from medic_hist where heart_probs = 'High BP' minus select patient_id from medic_hist where heart_probs = null;

--17  Use of group by
select doc3.dep_name, avg(doc2.salary) as avg_salary from doc3,doc2,doc1  where doc1.salary_slipno = doc2.salary_slipno and doc1.doc_id = doc3.doc_id group by doc3.dep_name having avg(doc2.salary)>500000

--18 altering doc1
alter table doc1 add (polyclinic_name varchar(20), foreign key(polyclinic_name) references polyclinic(polyclinic_name));
update doc1 set polyclinic_name = 'DentalPolyclinic' ;
select * from doc1;

--19  Each patient can go to all the doctors in the polyclinic
select doc1.doc_id, doc1.doc_name, patient1.patient_id ,patient1.patient_name from doc1, patient1 where doc1.polyclinic_name = patient1.polyclinic_name order by doc_id asc, patient_id asc;

--20
create view polyclinic_view as select
polyclinic_name, address, timings, phone_no from polyclinic with read only;
select * from polyclinic_view;

--21 using triggers
set serveroutput on;
create or replace trigger print_salary1
before delete or insert or update on doc2
for each row
when(new.salary_slipno>0)
declare
sal_diff number;
begin
sal_diff := :new.salary - :old.salary;
dbms_output.put_line('Old salary: '|| :old.salary);
dbms_output.put_line('New Salary: '|| :new.salary);
dbms_output.put_line('Difference '|| sal_diff);
end;
/
update doc2 set salary = salary+500 where salary_slipno = 100;

--22 10% Discount for Patients coming for 10 years and more:
set serveroutput on;
create or replace function discount_reg_patient(n1 in number)
return number is ans number;
begin
ans:= n1-0.1*n1;
return ans;
end discount_reg_patient ;
/
declare
n1 number:=&n1;
ans number;
begin
ans:=discount_reg_patient(n1);
dbms_output.put_line('Regular Patient(Coming for 10 years)');
dbms_output.put_line('Discount is '||0.1*n1);
dbms_output.put_line('Amount to be paid is '||ans);
end;  
/

--23 free checkup for new patient
set serveroutput on;
create or replace function ffcheckup_new_patient(n1 in number)
return number is ans number;
begin
ans:= n1*0;
return ans;
end ffcheckup_new_patient ;
/
declare
n1 number:=&n1;
ans number;
begin
ans:=ffcheckup_new_patient(n1);
dbms_output.put_line('New Patient (First Checkup Free)');
dbms_output.put_line('Amount to be paid is '||ans);
end;
/

--24 procedure for New Patient and Regular Patient

set serveroutput on;
create or replace procedure patient(n1 in number,c in number,ans out number)is
begin
if(c=1) then
ans:=discount_reg_patient(n1);
end if;
if(c=2) then
ans:=ffcheckup_new_patient(n1);
end if;
end patient;
/
declare
n1 number:=&n1;
c number:=&c;
ans number;
begin
patient(n1,c,ans);
dbms_output.put_line('Answer '||ans);
end;  
/

--25 using cursors to search for a doctor info by providing doc id
set serveroutput on;
DECLARE
   d_id doc1.doc_id%type := &d_id;
   d_name doc1.doc_name%type;
   d_sal doc1.salary_slipno%type;
   d_pno doc1.phone_no%type;
   CURSOR c_doc1 is
      SELECT doc_id, doc_name, salary_slipno,phone_no FROM doc1
      where doc_id=d_id;
BEGIN
   OPEN c_doc1;
   LOOP
   FETCH c_doc1 into d_id, d_name, d_sal,d_pno;
      EXIT WHEN c_doc1%notfound;
      dbms_output.put_line(d_id || ' ' || d_name || ' ' || d_sal|| ' ' ||d_pno);
   END LOOP;
   CLOSE c_doc1;
END;
/

--25 creating a audit table to store details of users,date,operstions performed in patient1 table
create table clinicaudit(
                        new_p1_id number(7) ,
                        old_p1_id number(7),
                        new_polyclinic_name varchar(20),
                        old_polyclinic_name varchar(20),
                        new_p1_name varchar(20),
                        old_p1_name varchar(20),
                        old_dob date,
                        new_dob date,
                        user_name varchar2(30),
                        entry_date varchar(30),
                        operation varchar(30));

--26 trigger to insert values automatically to audit table 
--when dml operations are performed in patient1 table                      
create or replace trigger p1audit
before insert or delete or update on patient1
for each row
enable
declare
    v_user varchar2(30);
    v_date varchar2(30);
begin
    select user ,to_char(sysdate, 'dd/mon/yyyy hh24:mi:ss')into v_user,v_date from dual;
    if inserting then
        insert into clinicaudit
        values(:new.patient_id, null, :new.polyclinic_name, null, :new.patient_name, null, :new.dob , null, v_user,v_date,'insert');
    elsif deleting then
        insert into clinicaudit
        values(null,:old.patient_id, null, :old.polyclinic_name, null, :old.patient_name, null, :old.dob , v_user,v_date,'delete');
    elsif updating then
        insert into clinicaudit
        values(:new.patient_id,:old.patient_id , :new.polyclinic_name, :old.polyclinic_name, :new.patient_name, :old.patient_name, :new.dob , :new.dob, v_user,v_date,'update');
    end if ;
end;
/
insert into patient1 values(9,'Dental Polyclinic','Mrs.ishu','28/07/1988');
delete from patient1 where patient_id = 9;
select * from clinicaudit;