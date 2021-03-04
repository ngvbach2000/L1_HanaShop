# Armor Management 
Lab 1: HanaShop 
(Java Web)

## Program Specifications:
Build a website that sells foods: coffee, cakes, candies, ... The website supports online payment or cash payment
upon delivery. You must use Servlet as Controller and follow MVC2 model.

## Features:
- Function 1: Login – 50 Points
o In order to shopping, an authentication is required.
o If the user has not authenticated, the system redirects to the login page.
o The actor enters userID and password, the function checks if the userID with the password is in the
available user list, then grant the access permission. If not, a message would appear to notify that user is
not found.
o Login function includes logout and welcome functions.

- Function 2: Search Foods/ Drinks – 50 Points
o List first 20 available items in the system order by date (status is active and quantity greater than 0). Paging
is required to use.
o Each food has a name, image, description, price, createDate, category, … fields
o User can find the food based on name or range of money or category.
o All users can use this function (login is not required)

- Function 3: Delete food/drink – 50 points
o The list of first 20 foods will be displayed (order by date). The food category and the food status will show
in combo box (drop down list) form. Paging is required to use.
o Remove the selected items.
o The confirm message will show before delete action.
o Update list food after delete.
o Remember that delete action is update the status of the Food to Inactive.
o The system must record the update date, update user.
o Only Admin role has permission to do this function.

- Function 4: Update Food – 50 points
o The list of first 20 foods will be displayed (order by date). The food category and the food status will show
in combo box (drop down list) form. Paging is required to use.
o Update information of the selected food: name, image, price, category, quantity, ... fields
o Update list Food after update.
o The system must record the update date, update user.
o Only Admin role has permission to do this function.- Function 5: Create Food – 50 points
o Create new Food.
o Import date is current date.
o The default status of new Food is active.
o Only Admin role has permission to do this function.

- Function 6: Shopping – 100 points
o Add the selected Food to shopping cart. The default quantity is 1.
o Each user can buy any available Food in the list (not limit the amount Food want to buy)
o User can view the selected Food in the cart. For each Food: Food name, amount, price, total. The screen
must show the total amount of money of this cart.
o User can remove the Food from the cart. The confirm message will show before delete action.
o User can update amount of each Food in cart.
o Click the Confirm button to store the Food to database (must store the buy date time). The warning
message will show if the selected Food is out of stock.
o The default payment is cash payment upon delivery.
o All users can use this function excepting Admin role
o Login is required

- Function 7: Shopping history – 50 points
o User can take over the shopping history.
o Support search function: search by name or shopping date
 
## Connect me via 
1. [Facebook](https://fb.me/ngvbach2000)
2. [Email](mailto:ngvbach2000@gmail.com)

#### © 2020 by @ngvbach2000:cow:
