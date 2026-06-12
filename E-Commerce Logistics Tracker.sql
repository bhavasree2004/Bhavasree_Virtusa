/* 
SQL - E-Commerce Logistics Tracker

Business Case:
SwiftShip is a third-party logistics provider. They handle thousands of packages daily. Their current challenge is Lost in Transit items and identifying which delivery partners are underperforming.

Problem Statement:
Create a tracking database that identifies delayed shipments and ranks delivery partners based on their Success Rate.

Tasks:
1. Schema Design: Create the following tables:Partners, Shipments, DeliveryLogs
2. Delayed Shipment Query: Write a query to find all shipments where - ActualDeliveryDate > PromisedDate
3. Performance Ranking: Use COUNT and GROUP BY to show how many - Successful deliveries, Returned deliveries, each partner handled.
4. Zone Filter: Identify the most popular Destination City for orders placed in the last 30 days to help the warehouse plan truck routes.
*/

-- 1. CREATE TABLES

CREATE TABLE Partners (
    partner_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Shipments (
    shipment_id INT PRIMARY KEY,
    partner_id INT,
    destination_city VARCHAR(50),
    promised_date DATE,
    actual_delivery_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (partner_id) REFERENCES Partners(partner_id)
);

CREATE TABLE DeliveryLogs (
    log_id INT PRIMARY KEY,
    shipment_id INT,
    status VARCHAR(20),
    log_date DATE,
    FOREIGN KEY (shipment_id) REFERENCES Shipments(shipment_id)
);

-- INSERT SAMPLE DATA

INSERT INTO Partners VALUES
(1, 'DHL'),
(2, 'FedEx'),
(3, 'BlueDart');

INSERT INTO Shipments VALUES
(101, 1, 'Chennai', '2026-04-01', '2026-04-02', 'Delivered'),
(102, 2, 'Bangalore', '2026-04-01', '2026-04-05', 'Delivered'),
(103, 3, 'Hyderabad', '2026-04-02', '2026-04-02', 'Delivered'),
(104, 1, 'Chennai', '2026-04-03', '2026-04-06', 'Returned'),
(105, 2, 'Delhi', '2026-04-03', '2026-04-03', 'Delivered'),
(106, 3, 'Chennai', '2026-04-04', '2026-04-08', 'Returned'),
(107, 1, 'Mumbai', '2026-04-05', '2026-04-05', 'Delivered');

INSERT INTO DeliveryLogs VALUES
(1, 101, 'Delivered', '2026-04-02'),
(2, 102, 'Delivered', '2026-04-05'),
(3, 103, 'Delivered', '2026-04-02'),
(4, 104, 'Returned', '2026-04-06'),
(5, 105, 'Delivered', '2026-04-03');

-- 3. DELAYED SHIPMENTS

SELECT shipment_id, destination_city, promised_date, actual_delivery_date
FROM Shipments
WHERE actual_delivery_date > promised_date;

-- 4. PARTNER PERFORMANCE (Delivered vs Returned)

SELECT partner_id, status, COUNT(*) AS total
FROM Shipments
GROUP BY partner_id, status;

-- 5. ZONE FILTER (Last 30 Days Popular City)

SELECT destination_city, COUNT(*) AS total_orders
FROM Shipments
GROUP BY destination_city
ORDER BY total_orders DESC;

-- 6. PARTNER SCORECARD (Fewest Delays)

SELECT partner_id,
COUNT(CASE WHEN actual_delivery_date > promised_date THEN 1 END) AS delayed_shipments
FROM Shipments
GROUP BY partner_id
ORDER BY delayed_shipments ASC;
