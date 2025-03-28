-- Задача 1
with recursive employee_hierarchy as (
    select
        employeeid,
        name,
        managerid,
        departmentid,
        roleid
    from employees
    where employeeid = 1

    union all

    select
        e.employeeid,
        e.name,
        e.managerid,
        e.departmentid,
        e.roleid
    from employees e
    join employee_hierarchy eh on e.managerid = eh.employeeid
)
select
    eh.employeeid,
    eh.name,
    eh.managerid,
    d.departmentname,
    r.rolename,
    coalesce(string_agg(distinct p.projectname, ',' order by p.projectname)) as projects_names,
    coalesce(string_agg(distinct t.taskname, ',' order by t.taskname)) as tasks_names
from employee_hierarchy eh
left join departments d on eh.departmentid = d.departmentid
left join roles r on eh.roleid =  r.roleid
left join projects p on p.departmentid = eh.departmentid
left join tasks t on eh.employeeid = t.assignedto
group by eh.employeeid, eh.name, eh.managerid, d.departmentname, r.rolename
order by eh.name