create database OrderManagementDB;
use OrderManagementDB;

CREATE TABLE Customers (
    customerId INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(50)
);

select * from Customers;

INSERT INTO Customers VALUES (1, 'John', 'Doe', 'johndoe@example.com'),
       (2, 'Jane', 'Doe', 'janedoe@example.com'),
       (3, 'Bob', 'Smith', 'bobsmith@example.com'),
       (4, 'Alice', 'Jones', 'alicejones@example.com'),
       (5, 'Joe', 'Brown', 'joebrown@example.com');

CREATE TABLE Orders (
    orderId INT PRIMARY KEY,
    orderDate DATE,
    customerId INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId)
);

select * from Customers;
select * from Orders;

INSERT INTO Orders (orderId, orderDate, customerId, amount)
VALUES (1, '2022-01-01', 1, 100.00),
       (2, '2022-01-02', 1, 200.00),
       (3, '2022-01-03', 2, 150.00),
       (4, '2022-01-04', 3, 75.50),
       (5, '2022-01-05', 4, 250.00),
       (6, '2022-01-06', 1, 175.00),
       (7, '2022-01-07', 1, 225.00),
       (8, '2022-01-08', 2, 80.00),
       (9, '2022-01-09', 2, 100.00),
       (10, '2022-01-10', 2, 50.00),
       (11, '2022-01-11', 3, 150.00),
       (12, '2022-01-12', 4, 300.00),
       (13, '2022-01-13', 4, 125.00),
       (14, '2022-01-14', 5, 200.00),
       (15, '2022-01-15', 5, 175.00);

CREATE TABLE Payments (
    paymentId INT PRIMARY KEY,
    orderId INT,
    amountPaid DECIMAL(10,2),
    paymentDate DATE,
    FOREIGN KEY (orderId) REFERENCES Orders(orderId)
);

INSERT INTO Payments (paymentId, orderId, amountPaid, paymentDate)
VALUES (1, 1, 50.00, '2022-01-01'),
       (2, 1, 75.00, '2022-01-02'),
       (3, 2, 200.00, '2022-01-03'),
       (4, 3, 50.00, '2022-01-04'),
       (5, 3, 30.00, '2022-01-05'),
       (6, 3, 50.00, '2022-01-06'),
       (7, 11, 100.00, '2022-01-07'),
       (8, 12, 250.00, '2022-01-08'),
       (9, 12, 50.00, '2022-01-09'),
       (10, 15, 100.00, '2022-01-10'),
       (11, 15, 75.00, '2022-01-11');

select * from Customers;
select * from Orders;
select * from Payments;

/*write a query to get : firstName, totalOrderAmount*/

SELECT firstName, SUM(amount) AS totalOrderAmount
FROM Customers
INNER JOIN Orders ON Customers.customerId = Orders.customerId
GROUP BY firstName;


/*write a query to get : firstName, totalOrderAmount, totalPaymentAmount, Balance */

SELECT firstName, SUM(amount) AS totalOrderAmount, SUM(amountPaid) AS totalPaymentAmount,
(SUM(amount) - SUM(amountPaid)) AS Balance
FROM Customers
INNER JOIN Orders ON Customers.customerId = Orders.customerId
INNER JOIN Payments ON Orders.orderId = Payments.orderId
GROUP BY firstName;


/*Update previous query -> only those records that have balance > 100, highest balance customer should be first*/

SELECT firstName, SUM(amount) AS totalOrderAmount, SUM(amountPaid) AS totalPaymentAmount,
(SUM(amount) - SUM(amountPaid)) AS Balance
FROM Customers
INNER JOIN Orders ON Customers.customerId = Orders.customerId
INNER JOIN Payments ON Orders.orderId = Payments.orderId
GROUP BY firstName
HAVING (SUM(amount) - SUM(amountPaid)) > 100
ORDER BY Balance DESC;

/*write down a query to retrive - OrderDate ,FirstName, OrderId, OrderAmount, AmountPaidAgainstThatOrder, BalanceAmount - Sort by orderDate asc*/

SELECT orderDate, firstName, Orders.orderId, amount AS OrderAmount, amountPaid, (amount - amountPaid) AS balance
FROM Customers 
INNER JOIN Orders ON Customers.customerId = Orders.customerId
INNER JOIN Payments ON Orders.orderId = Payments.orderId
ORDER BY orderDate DESC;
