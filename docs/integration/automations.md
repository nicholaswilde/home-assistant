---
tags:
  - integration
---
# :robot: Automations

Automations that I use.

## :bulb: Lighting

The vast majority of my automations consist of controlling lights around the house.



### :sunrise_over_mountains: Sunset

At sunset, I turn on all of my outdoor lights and some indoor lights, such as kitchen cabinet and mantle lights.

### :crescent_moon: Night

At about 10:30 PM I turn off some indoor and outdoor lights, such as the mantle and gazebo lights.

### :sunrise: Sunrise

At sunrise, I turn off the rest of of my outdoor lights.

### :door: Closet & Pantry

Because my closet and pantry are dark, I need to turn on a light every time I open the doors. 

I have a zigbee or z-wave light switch that contols the light inside of the room so it can be manually turned on and off.

I have a recessed z-wave door sensor that senses when the door is opened, which then turns on the light.

the light is also turned off when the door is closed again.

The problem with this method is that the door sensor runs on a CR2 battery, which needs to be replaced every once in a while.

I can't get my low battery notifications to be consistent and so I rely on observations of when the light doesn't change to tell me that the battery needs to be changed.

I do use rechargeable CR2 batteries, which makes it more manageable.

## :wrench: Troubleshooting

To test or troubleshoot automations, you can manually trigger states or reset sensors via the Developer Tools.

### Manually Changing States

You can temporarily change the state of an entity to trigger an automation or test its conditions:

1. Go to **Developer tools** -> **States**.
2. Find the entity you want to change.
3. Update the state (e.g., from `off` to `on`) and click **Set State**.

### Resetting Entity States

After testing, you can force an entity to update its state from the source (resetting any manual changes):

1. Go to **Developer tools** -> **Actions**.
2. Search for the `homeassistant.update_entity` action.
3. Select the `entity_id` of the sensor/entity you wish to reset.
4. Click **Perform Action**.

## :link: References
