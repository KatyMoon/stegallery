/* $Id$ */

Module that integrates the services of Picnik (http://www.picnik.com) into a Drupal installation.

Installation
------------
1. Copy picnik.module to your module directory and then enable it on the admin modules page.
2. Go to http://www.picnik.com/keys/login and get a Picnik API Key
3. Enter the Key on the settings page admin/settings/picnik
4. Enter a path for temporary images
5. Select on which content types the module should look for images
6. Enter the CSS class or ID where node content is displayed in (only necessary for restricted user settings)
7. Enter a CSS class for images that should not be editable.
8. Grant permission for users

User permissions
----------------
There are three levels of permissions:
1. Administer picnik: Change settings of the picnik module
2. Edit all images: Edit all images on a site
3. Edit own images: Only edit images on nodes where the user has the edit permission

Note: To grant a user access to edit all images you also have to give him the "access own images" permission!

Author
------
Benjamin Koether
benjamin@imagexmedia.com, ben@koether.ca
