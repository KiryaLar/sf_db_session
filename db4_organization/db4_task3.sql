-- Задача 2
with recursive employee_hierarchy as (
    select
        employeeid,
        name,
        managerid,
        departmentid,
        r.roleid
    from employees
    inner join roles r on employees.roleid = r.roleid
    where r.rolename = 'Менеджер'

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
    coalesce(string_agg(distinct t.taskname, ',' order by t.taskname)) as tasks_names,
    count(distinct sub.employeeid) as total_subardinates
from employee_hierarchy eh
left join departments d on eh.departmentid = d.departmentid
left join roles r on eh.roleid =  r.roleid
left join projects p on p.departmentid = eh.departmentid
left join tasks t on eh.employeeid = t.assignedto
left join employees sub on eh.employeeid = sub.managerid
group by eh.employeeid, eh.name, eh.managerid, d.departmentname, r.rolename
having count(distinct sub.employeeid) > 0
order by eh.name;