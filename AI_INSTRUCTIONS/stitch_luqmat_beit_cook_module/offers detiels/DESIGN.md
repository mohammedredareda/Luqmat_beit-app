---
name: Sumac
colors:
  surface: '#FFFFFF'
  surface-dim: '#e8d7cc'
  surface-bright: '#fff8f5'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#fff1e8'
  surface-container: '#fcebdf'
  surface-container-high: '#f6e5da'
  surface-container-highest: '#f0dfd4'
  on-surface: '#221a13'
  on-surface-variant: '#58413e'
  inverse-surface: '#382e27'
  inverse-on-surface: '#ffeee2'
  outline: '#D9CEC1'
  outline-variant: '#e0bfba'
  surface-tint: '#ab3428'
  primary: '#871a11'
  on-primary: '#ffffff'
  primary-container: '#a83226'
  on-primary-container: '#ffc9c0'
  inverse-primary: '#ffb4a9'
  secondary: '#4e6628'
  on-secondary: '#ffffff'
  secondary-container: '#d0eda0'
  on-secondary-container: '#546c2e'
  tertiary: '#623c00'
  on-tertiary: '#ffffff'
  tertiary-container: '#825100'
  on-tertiary-container: '#ffcc91'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdad5'
  primary-fixed-dim: '#ffb4a9'
  on-primary-fixed: '#410000'
  on-primary-fixed-variant: '#8a1c13'
  secondary-fixed: '#d0eda0'
  secondary-fixed-dim: '#b4d086'
  on-secondary-fixed: '#121f00'
  on-secondary-fixed-variant: '#374d12'
  tertiary-fixed: '#ffddb8'
  tertiary-fixed-dim: '#ffb95f'
  on-tertiary-fixed: '#2a1700'
  on-tertiary-fixed-variant: '#653e00'
  background: '#fff8f5'
  on-background: '#221a13'
  surface-variant: '#f0dfd4'
  sumac-primary: '#A83226'
  zaatar-secondary: '#5A7233'
  honey-tertiary: '#B97A1E'
  tahini-bg: '#FBF7F1'
  ink-text: '#2A211A'
  muted-spice: '#71655B'
  sumac-container: '#FADDD7'
  zaatar-container: '#E4EDD3'
  honey-container: '#F7E7CC'
typography:
  display-lg:
    fontFamily: Alexandria
    fontSize: 40px
    fontWeight: '800'
    lineHeight: 48px
  headline-md:
    fontFamily: Alexandria
    fontSize: 22px
    fontWeight: '700'
    lineHeight: 28px
  headline-sm:
    fontFamily: Alexandria
    fontSize: 18px
    fontWeight: '700'
    lineHeight: 24px
  title-lg:
    fontFamily: Alexandria
    fontSize: 17px
    fontWeight: '700'
    lineHeight: 22px
  body-lg:
    fontFamily: Tajawal
    fontSize: 15.5px
    fontWeight: '500'
    lineHeight: 26px
  body-md:
    fontFamily: Tajawal
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 24px
  label-lg:
    fontFamily: Tajawal
    fontSize: 14px
    fontWeight: '700'
    lineHeight: 20px
  body-sm:
    fontFamily: Tajawal
    fontSize: 12.5px
    fontWeight: '400'
    lineHeight: 18px
  price-display:
    fontFamily: Tajawal
    fontSize: 16px
    fontWeight: '800'
    lineHeight: 20px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 12px
  lg: 16px
  xl: 24px
  xxl: 32px
  gutter: 16px
  card-padding: 14px
---

## Brand & Style

The design system is built on the philosophy of **"Domestic Professionalism."** It aims to bridge the gap between the warmth of a home kitchen and the reliability of a high-end logistics service. The aesthetic is **Modern Minimalist with a Warm Soul**, avoiding the clinical coldness of typical tech startups in favor of an artisanal, culinary-inspired atmosphere.

### Visual Narrative
- **Minimalism:** Use generous white space (Tahini background) to let high-quality food photography be the "hero."
- **Warmth:** No pure blacks or grays. Every neutral tone contains a hint of brown or red to maintain a "cooked" and inviting feel.
- **RTL-First:** The system is architected from the right-to-left perspective, ensuring that visual weight, iconography, and navigation feel native to Arabic-speaking users.
- **Tone:** Professional, clean, and trustworthy, yet approachable and "homemade."

## Colors

The palette is named after the essential flavors of the Levantine pantry. It follows a functional Material 3 logic, utilizing "Container" and "On-Container" roles to ensure accessibility and hierarchy.

- **Sumac (Primary):** A deep, earthy red used for the most important actions, branding, and active states.
- **Zaatar (Secondary):** A natural olive green used for "Success" states, freshness indicators, and secondary positive actions.
- **Honey (Tertiary):** A warm amber used for ratings, "Best Seller" tags, and gentle alerts.
- **Tahini (Background):** A warm, off-white surface that serves as the canvas, preventing the "screen glare" of pure white.
- **Ink (Neutral):** A deep, chocolate-toned charcoal used for all primary text.

**Contrast Note:** All text-on-background combinations must maintain a minimum 4.5:1 ratio. In Dark Mode, surfaces shift to a deep "Coffee" brown (`#1E1712`).

## Typography

This design system uses a dual-font strategy to balance character with readability.

- **Alexandria:** Used exclusively for headlines and display text. Its geometric structure provides a modern, professional framing for the app’s sections.
- **Tajawal:** Used for all body text, labels, and descriptions. Its softer, more humanist curves feel friendly and are highly legible at smaller sizes.

**Hard Rules:**
1. **Never** use Alexandria for body text.
2. **Numerals:** Prices, weights, and times must always use Latin glyphs (`1234567890`) for rapid scanning, even within Arabic text strings.
3. **Alignment:** All text is Right-Aligned by default, except for technical IDs or Monospace kickers which may be LTR.

## Layout & Spacing

The system follows a strict **8pt rhythm (4pt base unit)** to ensure mathematical harmony across all screen sizes.

- **Grid:** A fluid 4-column grid for mobile, expanding to 12 columns for tablet/desktop.
- **Margins:** Standard mobile screen margins are set to `16px` (lg).
- **Gaps:** Use `12px` (md) between cards in a list and `24px` (xl) between distinct logical sections.
- **Touch Targets:** All interactive elements (buttons, chips, icons) must maintain a minimum touch target of **48x48px**, regardless of their visual size.

## Elevation & Depth

Hierarchy is established through **Tonal Layering** and soft, warm shadows. We avoid pure gray shadows to prevent the UI from looking "dirty" on the warm Tahini background.

- **Surface Tiering:** The background is `Tahini`. Primary surfaces (Cards, Inputs) are `Surface White`.
- **Shadow Character:** Shadows use a brown-tinted base (`rgba(43, 33, 26, opacity)`).
- **Elevation levels:**
    - **Level 1 (Static Cards):** A very subtle 1px/2px diffused shadow to lift the card from the background.
    - **Level 2 (Floating Action Buttons):** A more pronounced 12px blur for elements that sit above the main content.
    - **Level 3 (Modals/Sheets):** High-diffusion 32px blur to focus user attention on the overlay.
- **Flat Fallback:** In Dark Mode, elevation is communicated via `Outline` borders rather than shadows.

## Shapes

The shape language is **Organic and Friendly**, utilizing significant rounding to evoke a sense of "home-made" comfort.

- **Primary Radius (14px):** Applied to the majority of containers, including Meal Cards, review blocks, and secondary buttons.
- **Input Radius (12px):** Used for text fields and search bars.
- **Overlay Radius (24px):** Specifically for the top corners of Bottom Sheets and Dialogs.
- **Pill (999px):** Reserved for chips, status tags (e.g., "Ready"), and profile avatars.
- **Image Aspect Ratio:** All food-related imagery must strictly follow a **4:3 ratio** to ensure consistency in the feed.

## Components

### Buttons
- **Primary:** Filled with `Sumac-Primary` with `On-Primary` text. 48px height.
- **Secondary:** Outlined with `Outline` color or filled with `Sumac-Container`. 
- **Destructive:** Outlined with `Error` red; never filled unless it is the final confirmation in a modal.

### Input Fields
- **Style:** Outlined with a 1.5px border. Labels should be floating or positioned above the field in `Muted-Spice`.
- **States:** Focus uses `Sumac-Primary`. Errors use a 2px `Error` red border with a supporting icon.

### Meal Cards
- **Structure:** 4:3 image on top, followed by `Title-lg` for the meal name, then a small row for price and rating.
- **Constraint:** Do not place an "Add to Cart" button directly on the card; the user must be encouraged to view the meal details first.

### Navigation
- **Bottom Bar:** 4-5 destinations max. The active state is indicated by a `Sumac-Container` pill behind the icon.
- **Top Bar:** Centered `Headline-sm` for the page title, with a right-aligned back arrow (flipped for RTL).

### Loading & Feedback
- **Skeletons:** Always use skeleton screens for loading states. The shimmer should be a subtle warm-tone gradient.
- **Transitions:** Elements must slide or fade over 200ms. Avoid instant "jumps" when content appears.