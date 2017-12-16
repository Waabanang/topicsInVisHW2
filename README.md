# HW2: Wind Visualization
##### Second homework for Comp494 at Macalester College, taught by Professor Bret Jackson
##### Authors: Micah Tanning & Waabanang Hermes

In this visualization, we drew animated particles to describe wind patterns across the United States.

### Parameters
**pcount** - the total number of simulated particles <br>
**maxlife** - longest possible lifetime of a particle, in milliseconds <br>
**minlife** - shortest possible lifetime of a particle, in milliseconds <br>
**stepsize** - step size for the RK4 integration <br>

By changing the step size, you can adjust the overall speed of the particles, as well as the distance each travels within its lifespan. We set this value to 0.1.

At higher values, such as 0.2 and 0.3, we noticed the particles tend to congregate in certain areas where the surrounding winds push particles inward and not outward (like a black hole), and along other well defined paths. Because the increased step size causes the particles to travel farther before dying, each one is more likely to get funneled into these areas, then stay there until it resets. This causes the rest of the map to look sparse.

At lower values, the particles move slower, and it becomes more and more difficult to compare relative velocities. We found a step size of 0.1 to be a good middle ground.

### Wizardly Work
In addition to the above features, we made each particle fade in and out at the beginning and end of its lifespan. This helped make the animation appear smoother.
