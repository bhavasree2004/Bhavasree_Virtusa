-- =====================================
-- 1. CREATE TABLES
-- =====================================

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


-- =====================================
-- 2. INSERT SAMPLE DATA
-- =====================================

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


-- =====================================
-- 3. DELAYED SHIPMENTS
-- =====================================

SELECT shipment_id, destination_city, promised_date, actual_delivery_date
FROM Shipments
WHERE actual_delivery_date > promised_date;


-- =====================================
-- 4. PARTNER PERFORMANCE (Delivered vs Returned)
-- =====================================

SELECT partner_id, status, COUNT(*) AS total
FROM Shipments
GROUP BY partner_id, status;


-- =====================================
-- 5. ZONE FILTER (Last 30 Days Popular City)
-- =====================================

SELECT destination_city, COUNT(*) AS total_orders
FROM Shipments
WHERE actual_delivery_date >= CURDATE() - INTERVAL 30 DAY
GROUP BY destination_city
ORDER BY total_orders DESC;


-- =====================================
-- 6. PARTNER SCORECARD (Fewest Delays)
-- =====================================

SELECT partner_id,
       COUNT(CASE WHEN actual_delivery_date > promised_date THEN 1 END) AS delayed_shipments
FROM Shipments
GROUP BY partner_id
ORDER BY delayed_shipments ASC;


-- =====================================
-- 7. BONUS: SUCCESS RATE (Optional)
-- =====================================

SELECT partner_id,
       SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate
FROM Shipments
GROUP BY partner_id;