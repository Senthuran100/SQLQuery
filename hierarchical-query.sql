
-- Create a category table
CREATE TABLE category (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  title varchar(255) NOT NULL,
  parent_id int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (parent_id) REFERENCES category (id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Inserting data into category table.
INSERT INTO category(title,parent_id) 
VALUES('Electronics',NULL);

INSERT INTO category(title,parent_id) 
VALUES('Laptops & PC',1);


INSERT INTO category(title,parent_id) 
VALUES('Laptops',2);
INSERT INTO category(title,parent_id) 
VALUES('PC',2);

INSERT INTO category(title,parent_id) 
VALUES('Cameras & photo',1);
INSERT INTO category(title,parent_id) 
VALUES('Camera',5);

INSERT INTO category(title,parent_id) 
VALUES('Phones & Accessories',1);
INSERT INTO category(title,parent_id) 
VALUES('Smartphones',7);

INSERT INTO category(title,parent_id) 
VALUES('Android',8);
INSERT INTO category(title,parent_id) 
VALUES('iOS',8);
INSERT INTO category(title,parent_id) 
VALUES('Other Smartphones',8);

INSERT INTO category(title,parent_id) 
VALUES('Batteries',7);
INSERT INTO category(title,parent_id) 
VALUES('Headsets',7);
INSERT INTO category(title,parent_id) 
VALUES('Screen Protectors',7);

-- Finding the root node.
SELECT * FROM category c where c.parent_id is NULL

-- Find the immediate leaf node
SELECT * from category c where parent_id = (SELECT id FROM category c where c.parent_id is NULL);

--Find the leaf node.
SELECT c.id, c.title  from category c 
LEFT JOIN category c2 on c.id = c2.parent_id 
where c2.id is NULL 

-- Finding the whole tree
WITH RECURSIVE category_path(id,title, path) AS 
(
SELECT id, title, title as path
from category c 
where c.parent_id is NULL 
UNION ALL 
SELECT c2.id , c2.title , CONCAT(cp.path,'>',c2.title)  FROM category_path cp JOIN category c2 
ON cp.id = c2.parent_id 
)
SELECT * from category_path
ORDER BY path

-- Calculating the level of the subtree
WITH RECURSIVE category_path(id,title, level) AS 
(
SELECT id, title, 0 level
from category c 
where c.parent_id is NULL 
UNION ALL 
SELECT c2.id , c2.title , cp.level+1  FROM category_path cp JOIN category c2 
ON cp.id = c2.parent_id 
)
SELECT * from category_path
ORDER BY level