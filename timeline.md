## 1. Specification
- Populate each table with sufficient items to demonstrate functionality (1-2 days)
- Select relation(s) to preform operation(s) on:
    - Insert
        - The user should be able to specify what values to insert. That is, do not limit the user to a particular set of values to insert. The user should be able to insert any value they want
    - Update
        - In this relation, the user should be able to update any number of non-primary key attributes
    - Delete
        - The user should be able to choose what values to delete. They can do this by specifying the primary key, selecting from a list of tuples, or using another reasonable method of your choice.
    - Selection
        - The user should be allowed to search for tuples using any number of AND and OR clauses and combinations of attributes. Conditions can be based on equality or (if you want) more complex operations (e.g., less than).
    - Projection
        - The user can choose any number of attributes to view from this relation. Non-selected attributes must not appear in the result.
        - The user should be able to choose the order of the attributes in the answer. For example, if there is R(A, B, C), the user should be able to choose that the results should appear in the order of B, A, C. The order of the attributes cannot be changed on the client side; the query that gets sent to the database must fetch the tuples in the user-specified order.
    - Join
        - The user must provide at least one value to qualify in the WHERE clause (e.g., join the Customer and the Transaction relation to find the names and phone numbers of all customers who have purchased a specific item).
- Aggregation with:
    - Group By
        - You must provide an interface (e.g., button, dropdown, etc.) for the user to execute the query.
    - Having
        - You must provide an interface (e.g., button, dropdown, etc.) for the user to execute the query.
    - Division
        - You must provide an interface (e.g., button, dropdown, etc.) for the user to execute the query.
- Graphical User Interface (GUI)
    - The GUI doesn’t need to be fancy, but at least a basic GUI is necessary. The GUI should be usable from the perspective of a non-computer scientist and should not include SQL syntax. If the project does not have a GUI (e.g., it is run through command line) or the GUI is severely broken, a penalty of 40% on the total value of the project grade will be applied.
    - You cannot use a GUI generating tool.
- Error handling
    - The user receives notifications about user errors such as trying to insert a duplicate value, invalid input (e.g., invalid characters or an int when only strings are allowed), etc.
- Drop, Recreate, and Reload Tables
    - Groups should be able to use the .sql file submitted for Milestone 4 to drop, recreate, and reload tables.
- Sufficient User Data
    - Note that each of your queries must have some non-trivial answers. For example, division with only two products is trivial. Likewise, aggregation (GROUP BY) must produce a reasonable number of groups, and some groups must have more than one row. This means that you must insert enough data in your database using this script to ensure non-trivial query results.
- User Notification
    - The user will receive a success or failure notification upon the completion of an insert, update, delete action and will have a way to verify the action's effect on the database.
- User-friendly query results
    - Queries are designed to only return the data that is needed and in the right order if required. The client does not do any processing of the data such as filtering/sorting etc.
- User-friendliness
    - The application is designed for someone who has no knowledge of Computer Science. The interaction and required inputs are reasonable for a non-Computer Scientists (e.g., the user is not required to input a condition such as attributeName <op> value to do a search). The application is designed in a way that is reasonable for users (e.g., having everything on a really long page is not reasonable).

## 2. Timeline 

Task assignments are flexible. All three members are expected to collaborate and help each other out depending on difficulty and progress. The goal is equal overall contribution.

### Currently In Progress
- Fix DDL issues and finalize entity tables
- Write `INSERT` scripts for at least 5 rows per table so queries return interesting results
- Verify all FK constraints resolve with no errors
- Each member sets up Git config and makes at least one UBC GitHub commit
- Each member runs the sample project locally and understands the file structure

---

### To-Do
#### Setup Backend: Node.js + Express (~2 weeks) | All members
- Write up specification (i.e., identify input/output partitions, errors, etc...) (4 days)
- Implement basic CRUD endpoints (Insert, Update, Delete), split entities across members (3 days)
- Test basic endpoints, each person creates tests for the endpoints they implement (2 days)
- Implement endpoints for remaining queries (Selection, Projection, Join, Aggregation, Nested Aggregation, Division), split across members (4 days)
- Test advanced endpoints (2 days)

#### Setup Frontend: React (~1.5 week) | All members
- Build views for core entities: Users, Software, Packages, Findings. Each person creates the views for their endpoints (5 days)
- Wire up forms for Insert, Update, Selection, Projection, Join (3 days)
- Wire up Delete with cascade confirmation + success/failure notifications (2 days)
- UI polish: ensure no SQL syntax visible, usable by a non-CS person, reasonable layout (2 days)

#### Final Polish + Submission (~1 week)
- Add input sanitization to all routes (prevent SQL injection)
- Verify SQL script drops, recreates, and reloads all tables cleanly
- Ensure sufficient non-trivial data for all queries (enough rows for GROUP BY groups, Division to be meaningful, etc.)
- Write Milestone 4 PDF (project description, schema changes, DB state screenshot, query index)
- Full dry-run demo before Milestone 5