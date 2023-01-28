--1. A user-defined function returns the number of unique customers.

ALTER FUNCTION UniqueCustomerssCount
()
RETURNS TABLE
AS
RETURN(
          SELECT DISTINCT C.[ContactName],COUNT(C.[ContactName]) AS CustomersCount
          FROM Customers AS C 
          GROUP BY C.[ContactName]
)

SELECT * FROM UniqueCustomerssCount() 

--2. A user-defined function returns the average price of a product
--of a particular type. Product type is passed as a parameter. For
--example, the average price of shoes.

ALTER FUNCTION AverageProductPrice(@productCategoryId INT)
RETURNS INT
AS
BEGIN
           DECLARE @productAvg INT
           SELECT @productAvg=AVG(P.[UnitPrice])
           FROM Products AS P
           WHERE P.[CategoryID]=@productCategoryId


           RETURN @productAvg
END

DECLARE @result INT
EXEC @result=AverageProductPrice 1
PRINT  @result

SELECT * FROM Products


--3. A user-defined function returns the average price of sales for
--each date when something was sold.

CREATE FUNCTION OrdersAverage(@ordersDateTime DATETIME)
RETURNS INT
AS
BEGIN

          DECLARE @ordersAvg AS INT
          SELECT @ordersAvg=AVG(P.[UnitPrice])
          FROM Products AS P,Orders AS O
          WHERE O.ShippedDate=@ordersDateTime
          
          RETURN @ordersAvg

END

DECLARE @result AS INT
EXEC @result=OrdersAverage '1996-07-16 00:00:00.000'
PRINT @result

SELECT * FROM Orders

--4 A user-defined function returns information about the last item
--sold. The parameter for the last item sold is the date of sale.

CREATE FUNCTION LastProductInfo(@sellDateTime AS DATETIME)
RETURNS TABLE
AS
RETURN(
SELECT *
FROM Orders AS O
WHERE @sellDateTime=O.ShippedDate
)

SELECT * FROM LastProductInfo ('1998-05-06 00:00:00.000')


--5
CREATE FUNCTION FirstProductInfo(@SellDateTime AS DATETIME)
RETURNS TABLE
AS
RETURN(
SELECT *
FROM Orders AS O
WHERE @SellDateTime=O.ShippedDate
)

SELECT * FROM LastProductInfo ('1996-08-01 00:00:00.000')


--6 A user-defined function returns information about the specified
--type of products of a particular manufacturer. Product type and
--manufacturer name are passed as parameters.

CREATE FUNCTION ProductInfo(@categoryId AS INT,@productName AS NVARCHAR(50))
RETURNS TABLE
AS
RETURN(
SELECT *
FROM Products AS P
WHERE @categoryId=P.CategoryID AND @productName=P.[ProductName]
)

SELECT* FROM ProductInfo (1,'Chai') 



