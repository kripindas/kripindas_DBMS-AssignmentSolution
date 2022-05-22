/* 3. Display the total number of customers based on gender who have placed orders of worth at least Rs.3000. */

SELECT COUNT(C.CUS_ID) AS COUNT,C.CUS_GENDER AS GENDER FROM ORDERS O INNER JOIN CUSTOMER C ON O.CUS_ID=C.CUS_ID WHERE O.ORD_AMOUNT<=3000 GROUP BY C.CUS_GENDER;

/* 4. Display all the orders along with product name ordered by a customer having Customer_Id=2 */

SELECT O.ORD_ID,O.ORD_AMOUNT,O.ORD_DATE,P.PRO_NAME,C.CUS_ID,C.CUS_NAME FROM ORDERS O INNER JOIN CUSTOMER C ON O.CUS_ID=C.CUS_ID INNER JOIN SUPPLIER_PRICING S ON O.PRICING_ID=S.PRICING_ID INNER JOIN PRODUCT P ON S.PRO_ID=P.PRO_ID  WHERE C.CUS_ID=2;

/* 5. Display the Supplier details who can supply more than one product. */

SELECT S.SUPP_ID,S.SUPP_NAME,S.SUPP_CITY,S.SUPP_PHONE FROM SUPPLIER S
INNER JOIN SUPPLIER_PRICING SP ON S.SUPP_ID=SP.SUPP_ID GROUP BY S.SUPP_ID HAVING COUNT(SP.PRO_ID)>1;

/* 6. Find the least expensive product from each category and print the table with category id, name, product name and price of the product */

SELECT C.CAT_ID,C.CAT_NAME,MIN(SP.SUPPLIER_PRICE) AS MIN_PRICE,P.PRO_NAME FROM PRODUCT P INNER JOIN CATEGORY C ON P.CAT_ID=C.CAT_ID INNER JOIN SUPPLIER_PRICING SP ON P.PRO_ID=SP.PRO_ID GROUP BY C.CAT_ID,P.PRO_NAME ;

/* 7. Display the Id and Name of the Product ordered after “2021-10-05” */

SELECT P.PRO_ID,P.PRO_NAME AS PRODUCT_NAME FROM ORDERS O INNER JOIN SUPPLIER_PRICING SP ON O.PRICING_ID=SP.PRICING_ID
INNER JOIN PRODUCT P ON SP.PRO_ID=P.PRO_ID WHERE O.ORD_DATE>'2021-10-05';

/* 8. Display customer name and gender whose names start or end with character 'A'. */

SELECT C.CUS_NAME,C.CUS_GENDER FROM CUSTOMER C WHERE C.CUS_NAME LIKE 'A%' OR C.CUS_NAME LIKE '%A';

/* 9. Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print 'Excellent
Service' ,If rating >4 print 'Good Service', If rating >2 print 'Average Service' else print 'Poor Service' */

    DELIMITER &&  
    CREATE PROCEDURE show_supplier_rating ()  
    BEGIN  
        SELECT S.SUPP_ID,S.SUPP_NAME,R.RAT_RATSTARTS AS RATING,
		CASE
		WHEN R.RAT_RATSTARTS = 5 THEN 'Excellent Service'
		WHEN R.RAT_RATSTARTS > 4 THEN 'Good Service'
		WHEN R.RAT_RATSTARTS > 2 THEN 'Average Service'
		ELSE 'Poor Service'
		END AS TYPE_OF_SERVICE
		FROM SUPPLIER S INNER JOIN SUPPLIER_PRICING SP ON S.SUPP_ID=SP.SUPP_ID
		INNER JOIN ORDERS O ON SP.PRICING_ID=O.PRICING_ID
		INNER JOIN RATING R ON O.ORD_ID=R.ORD_ID;  
    END &&  
    DELIMITER ;  
    
CALL show_supplier_rating()
