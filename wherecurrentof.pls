declare
  cursor c_emps is select * from employees 
                    where department_id = 30 for update;
begin
  for r_emps in c_emps loop
    update employees set salary = salary + 60
          where current of c_emps;
  end loop;  
end;

---------------Wrong example of using where current of clause
declare
  cursor c_emps is select e.* from employees e, departments d
                    where 
                    e.department_id = d.department_id
                    and e.department_id = 30 for update;
begin
  for r_emps in c_emps loop
    update employees set salary = salary + 60
          where current of c_emps;
  end loop;  
end;
---------------An example of using rowid like where current of clause
declare
  cursor c_emps is select e.rowid,e.salary from employees e, departments d
                    where 
                    e.department_id = d.department_id
                    and e.department_id = 30 for update;
begin
  for r_emps in c_emps loop
    update employees set salary = salary + 60
          where rowid = r_emps.rowid;
  end loop;  
end;
/*With these rows, the database can find the rows much faster. Especially, if you do not use the primary key,it will be pretty much faster.
So how do we use the rowids then? It is by using the "where current of" clause.*/
