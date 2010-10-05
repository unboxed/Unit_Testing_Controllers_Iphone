- This project is an example on how to unit test a TableViewController. It implements two application and unit tests.

We'll implement a test as an application test when what we're testing resources like views, nibs files etc to work. 
In those cases logic tests will fail, because the enviroment in which they're run is not complete. Although I find 
quite dificult to find information about the limitations and expectations of those test execution enviroments.

The logic tests could have been implemented as Application tests (included in RootViewControllerAppTests). The separation is just
an attemp to follow the descriptions of the types of tests described by Apple.


- Controllers are hard to test because there are usually a lot of dependencies. You could also argue that you need to run the whole app
in order to test the controller. But here what we are trying is to unit test it. Test that it will return the right number columns,
or that the cells have the right text. And we can always test that at the integration tests level the app is working fine as a whole.
But at that level we will most likely pay less attention to the internal behaviour of the table.

- What the application does:
 Just implements a tableview controller, you can add the current date as elment of this list, and edit those.

