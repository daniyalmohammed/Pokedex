# Pokédex App
<img src="https://github.com/user-attachments/assets/50aaa562-cc39-4ede-8c21-97da966524bf" alt="PokedexAppSelectedImage" style="width: 300px; height: auto; border-radius: 15px;">

This is a simple Pokédex app built with Swift and SwiftUI that uses the [PokeAPI](https://pokeapi.co/) to display a list of Pokémon. You can scroll through a grid of Pokémon, and when you tap on one, its image and name will appear at the top of the screen.

## How the Code Works

The app fetches Pokémon data from the PokeAPI using `URLSession` and displays them in a 3-column grid using SwiftUI's `LazyVGrid`. As you scroll down the grid, the app loads more Pokémon from the API. For each Pokémon, I use `AsyncImage` to load its image asynchronously. When you tap on a Pokémon, the selected image and name show up in a larger view at the top.

## Design

The design is bright and colorful, inspired by the Pokémon vibes. The background is a cheerful yellow, while the grid uses light blue tiles. The selected Pokémon’s image is displayed at the top with its name in bold text below.

- **Colors**: I chose bright and fun colors to match the Pokémon theme.
- **Layout**: The layout is kept simple with enough spacing and padding to avoid clutter.
- **Responsive Design**: The layout adjusts to different screen sizes, so it looks good on any device. I also made sure that long text is handled with ellipses to prevent overflow.

## Technical Decisions

### AsyncImage
I went with `AsyncImage` for image loading because it’s built into SwiftUI and makes handling async image downloads easy. It automatically shows a loading indicator while fetching the image and handles failures with a placeholder image. Using `AsyncImage` keeps the code clean, and I don’t have to worry about manually managing network requests.

### Image Caching
For the grid images, I used a simple in-memory cache to avoid downloading the same images multiple times. This speeds up performance. I didn’t go with disk caching because, for this app, memory caching is sufficient and much easier to set up. Disk caching would have been overkill for the number of images I’m dealing with.
