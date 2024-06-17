use `goit-rdb-hw-03`;

#Напишіть запит за допомогою операторів FROM та INNER JOIN, що об’єднує всі таблиці даних, які ми завантажили з файлів:
# order_details, orders, customers, products, categories, employees, shippers, suppliers.
# Для цього ви маєте знайти спільні ключі.
select order_details.id as order_details_id,
       order_id,
       customer_id,
       e.employee_id,
       product_id,
       shipper_id,
       supplier_id,
       category_id
from order_details
join orders o on o.id = order_details.order_id
join customers c on c.id = o.customer_id
join employees e on o.employee_id = e.employee_id
join products p on p.id = order_details.product_id
join shippers s on s.id = o.shipper_id
join suppliers s2 on s2.id = p.supplier_id
join categories cat on cat.id = p.category_id;

# Визначте, скільки рядків ви отримали (за допомогою оператора COUNT).
select count(order_details.id) as row_amount
from order_details
         join orders o on o.id = order_details.order_id
         join customers c on c.id = o.customer_id
         join employees e on o.employee_id = e.employee_id
         join products p on p.id = order_details.product_id
         join shippers s on s.id = o.shipper_id
         join suppliers s2 on s2.id = p.supplier_id
         join categories cat on cat.id = p.category_id;

#Змініть декілька операторів INNER на LEFT чи RIGHT. Визначте, що відбувається з кількістю рядків. Чому?
# Напишіть відповідь у текстовому файлі.
select order_details.id as order_details_id,
       order_id,
       customer_id,
       e.employee_id,
       product_id,
       shipper_id,
       supplier_id,
       category_id
from order_details
         join orders o on o.id = order_details.order_id
         join customers c on c.id = o.customer_id
         join employees e on o.employee_id = e.employee_id
         join products p on p.id = order_details.product_id
         join shippers s on s.id = o.shipper_id
         join suppliers s2 on s2.id = p.supplier_id
         right join categories cat on cat.id = p.category_id;
## Відповідь: Я перевірила на всіх join замінивши inner join на right join та left join, кількість рядків не змінилась.
# Також на наявних данних я не помітила різниці в результатах запиту, хочу очікувала побачити NULL.
# Це може свідчити, що умова виконуєтьтся для всіх join, та в теперішніх данних немає приекладів невідповідності
# правої та лівої частини.
# Також я перевірила правиильністьт роботи змінивши данні та підмітила різницю в результатах при зміні послідовності join

#Оберіть тільки ті рядки, де employee_id > 3 та ≤ 10.
select order_details.id as order_details_id,
       order_id,
       customer_id,
       e.employee_id,
       product_id,
       shipper_id,
       supplier_id,
       category_id
from order_details
         join orders o on o.id = order_details.order_id
         join customers c on c.id = o.customer_id
         join employees e on o.employee_id = e.employee_id
         join products p on p.id = order_details.product_id
         join shippers s on s.id = o.shipper_id
         join suppliers s2 on s2.id = p.supplier_id
         join categories cat on cat.id = p.category_id
where e.employee_id > 3 and e.employee_id <= 10;

#Згрупуйте за іменем категорії, порахуйте кількість рядків у групі, середню кількість товару
#(кількість товару знаходиться в order_details.quantity)
select cat.name, count(order_details.id) as `кількість рядків у групі`, avg(order_details.quantity) as `середня кількість товару`
from order_details
         join orders o on o.id = order_details.order_id
         join customers c on c.id = o.customer_id
         join employees e on o.employee_id = e.employee_id
         join products p on p.id = order_details.product_id
         join shippers s on s.id = o.shipper_id
         join suppliers s2 on s2.id = p.supplier_id
         join categories cat on cat.id = p.category_id
group by cat.name;

#Відфільтруйте рядки, де середня кількість товару більша за 21.
select cat.name, avg(order_details.quantity) as `середня кількість товару`
from order_details
         join orders o on o.id = order_details.order_id
         join customers c on c.id = o.customer_id
         join employees e on o.employee_id = e.employee_id
         join products p on p.id = order_details.product_id
         join shippers s on s.id = o.shipper_id
         join suppliers s2 on s2.id = p.supplier_id
         join categories cat on cat.id = p.category_id
group by cat.name
having `середня кількість товару` > 21;

#Відсортуйте рядки за спаданням кількості рядків.
select cat.name, count(order_details.id) as `кількість рядків у групі`
from order_details
         join orders o on o.id = order_details.order_id
         join customers c on c.id = o.customer_id
         join employees e on o.employee_id = e.employee_id
         join products p on p.id = order_details.product_id
         join shippers s on s.id = o.shipper_id
         join suppliers s2 on s2.id = p.supplier_id
         join categories cat on cat.id = p.category_id
group by cat.name
order by `кількість рядків у групі` desc;

#Виведіть на екран (оберіть) чотири рядки з пропущеним першим рядком.
select cat.name, count(order_details.id) as `кількість рядків у групі`
from order_details
         join orders o on o.id = order_details.order_id
         join customers c on c.id = o.customer_id
         join employees e on o.employee_id = e.employee_id
         join products p on p.id = order_details.product_id
         join shippers s on s.id = o.shipper_id
         join suppliers s2 on s2.id = p.supplier_id
         join categories cat on cat.id = p.category_id
group by cat.name
order by `кількість рядків у групі` desc
limit 4 offset 1;