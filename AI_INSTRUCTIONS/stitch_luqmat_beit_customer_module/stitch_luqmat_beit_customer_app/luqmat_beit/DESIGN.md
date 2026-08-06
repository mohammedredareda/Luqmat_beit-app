---
name: Luqmat Beit
colors:
  surface: '#fff8f5'
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
  primary-container: '#FADDD7'
  on-primary-container: '#6E1A11'
  inverse-primary: '#ffb4a9'
  secondary: '#4e6628'
  on-secondary: '#ffffff'
  secondary-container: '#E4EDD3'
  on-secondary-container: '#546c2e'
  tertiary: '#623c00'
  on-tertiary: '#ffffff'
  tertiary-container: '#F7E7CC'
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
  surface-variant: '#F2EBE1'
  sumac-red: '#A83226'
  zaatar-green: '#5A7233'
  honey-gold: '#B97A1E'
  tahini-bg: '#FBF7F1'
  warm-charcoal: '#2A211A'
  ink-muted: '#71655B'
typography:
  display-lg:
    fontFamily: Alexandria
    fontSize: 40px
    fontWeight: '800'
    lineHeight: '1.35'
  display-lg-mobile:
    fontFamily: Alexandria
    fontSize: 30px
    fontWeight: '800'
    lineHeight: '1.35'
  headline-lg:
    fontFamily: Alexandria
    fontSize: 22px
    fontWeight: '700'
    lineHeight: '1.4'
  title-lg:
    fontFamily: Alexandria
    fontSize: 17px
    fontWeight: '700'
    lineHeight: '1.45'
  body-lg:
    fontFamily: Tajawal
    fontSize: 15.5px
    fontWeight: '500'
    lineHeight: '1.7'
  body-md:
    fontFamily: Tajawal
    fontSize: 14.5px
    fontWeight: '400'
    lineHeight: '1.75'
  label-lg:
    fontFamily: Tajawal
    fontSize: 14px
    fontWeight: '700'
    lineHeight: '1.2'
  body-sm:
    fontFamily: Tajawal
    fontSize: 12px
    fontWeight: '500'
    lineHeight: '1.5'
  price-display:
    fontFamily: Tajawal
    fontSize: 16px
    fontWeight: '800'
    lineHeight: '1.0'
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  xs: 4px
  s: 8px
  m: 12px
  l: 16px
  xl: 24px
  xxl: 32px
  margin-screen: 16px
  gutter-card: 12px
  padding-card: 14px
---

## Brand & Style

The design system for this product is rooted in the philosophy of "Homegrown, not Industrial." It captures the warmth, authenticity, and communal spirit of Levantine home cooking. The target audience includes both home chefs and food lovers seeking an artisanal, personal connection to their meals.

The visual style is a **Material 3 / Corporate Modern** hybrid with a **Tactile** soul. While it follows the rigorous logic of Material 3 (container-based architecture, clear hierarchy), it softens the "tech" feel through a warm, "Tahini" off-white base, organic color palettes inspired by Middle Eastern spices, and generous roundedness. The interface is designed to be "invisible," acting as a clean, warm canvas that allows vibrant food photography to be the hero. 

Key attributes:
- **Warmth:** No pure blacks or cold grays; every neutral is tinted with a sun-baked warmth.
- **RTL-First:** The layout logic is built specifically for Arabic script, ensuring balance and natural reading flow from right to left.
- **Artisanal Rigor:** The system balances the "imperfect" feel of a home kitchen with the precision of a high-end SaaS product.

## Colors

The palette is derived from the Levantine spice rack. **Sumac Red** serves as the primary action color, used for high-impact CTAs and brand-critical moments. **Zaatar Green** represents freshness and success, while **Honey Gold** is reserved for ratings and soft callouts.

The interface avoids pure white and pure black to prevent visual fatigue and maintain a "human" feel. The background uses **Tahini**, a creamy off-white, paired with **Warm Charcoal** for typography.

### Color Strategy
- **Functional Semantics:** Colors are mapped to the order lifecycle (e.g., Honey for pending, Zaatar for ready).
- **Dark Mode:** Utilizes a "Coffee-brown" base (`#1E1712`) instead of black. In dark mode, shadows are deprecated in favor of subtle `#3A2F26` borders to maintain depth without muddiness.
- **Accessibility:** Primary colors are lightened for dark mode (e.g., `#F2A093`) to ensure AA contrast against the dark brown surfaces.

## Typography

This design system employs a dual-font strategy optimized for Arabic legibility and geometric strength. 

- **Alexandria:** Used for structural elements (Headlines, Titles, App Bar) to provide a modern, geometric presence. It gives the brand its "professional" edge.
- **Tajawal:** Used for all body copy and labels. Its humanist terminals and warmer curves provide the "approachable" feel necessary for a home-cooked food platform.

### Typography Rules
- **Numerals:** All prices and quantities must use **Latin numerals** (1, 2, 3) for immediate cognitive processing, even within Arabic text strings.
- **Line Heights:** Generous line heights (up to 1.75 for body text) are mandated to prevent Arabic diacritics (harakat) from clashing between lines.
- **RTL Alignment:** Text is right-aligned by default. App Bar titles are centered for a balanced, symmetrical "Display" feel.

## Layout & Spacing

The system follows a strict **4pt Grid Rhythm**. All measurements—padding, margins, and heights—must be multiples of 4 to ensure a mathematical harmony across the UI.

### Layout Philosophy
- **Fluid Grid:** Content stretches to fill the container width while respecting fixed screen margins.
- **Screen Margins:** A standard 16px margin is enforced on all mobile views.
- **Component Spacing:** Use 12px for horizontal gaps between cards and 24px for vertical spacing between distinct logical sections.
- **RTL Logic:** Padding-left and padding-right tokens must be flipped programmatically. In this design system, "Start" always refers to the Right.
- **Touch Targets:** All interactive elements must maintain a minimum hit area of 48px, regardless of the visual size of the icon or label.

## Elevation & Depth

Hierarchy is established through **Tonal Layering** and **Warm Shadows**. To maintain the "organic" feel of the brand, cool-gray shadows are strictly forbidden.

- **Warm Shadows:** Elevation shadows use a tinted base (`rgba(43, 33, 26, ...)`) rather than pure black. This ensures that shadows on the Tahini background look like natural light depth rather than "dirt."
- **Low-Elevation Cards:** Standard meal cards use a subtle `--e1` shadow to appear slightly lifted from the background.
- **Floating Elements:** Bottom navigation bars and FABs use `--e2` for a more pronounced "floating" effect.
- **Overlays:** Bottom sheets and dialogs use `--e3` to create high-contrast depth during focused interactions.
- **Dark Mode Depth:** Shadows are disabled in dark mode. Depth is instead conveyed through thin 1px borders of `#3A2F26` and subtle shifts in surface color brightness.

## Shapes

The shape language is "Rounded" and friendly. Generous radii are used to reinforce the artisanal, non-industrial nature of the product.

- **Component Radius (14px):** Applied to buttons, cards, and input fields.
- **Container Radius (24px):** Used for top corners of bottom sheets to create a soft "envelope" feel when they slide up.
- **Pill (999px):** Reserved for chips (tags), profile avatars, and status badges.
- **Food Images:** Must strictly adhere to a **4:3 aspect ratio** with a 12px corner radius to maintain a consistent gallery feel.
- **Selection States:** Use a 6px radius for smaller decorative badges or "Tagline" elements.

## Components

### Buttons
- **Primary:** One per screen. Solid `Sumac Red` with `On-Primary` text. Full-width on mobile.
- **Secondary/Destructive:** Always "Outlined" with a 1.5px stroke. Never use a solid color for destructive actions (e.g., Delete/Reject) to avoid them competing with the Primary CTA.

### Input Fields
- **Styling:** Outlined style using the `Outline` token (1.5px). Focused states use `Sumac Red`.
- **Labels:** Use `Label Large` (Tajawal Bold).
- **Feedback:** Error states use `Error` red for both the border and the helper text.

### Cards
- **Meal Cards:** White background (`Surface`), 14px radius, and `--e1` shadow. 
- **Rule:** Never include an "Add to Cart" button directly on a list card; users must click through to the meal details to ensure they see ingredients/chef notes.

### Chips & Status
- **Status Badges:** Use the container-tonal pattern. For example, a "Delivered" status uses a `Secondary Container` (Zaatar Green) background with `On-Secondary Container` text.
- **Interactive Chips:** Used for category filtering; they toggle between `Surface Variant` (inactive) and `Primary Container` (active).

### Navigation
- **Bottom Nav:** Max 4 destinations. Active states use a `Primary Container` "pill" highlight behind the icon, following Material 3 guidelines.
- **App Bar:** Centered titles using Alexandria for a symmetrical, premium feel.

### Motion
- **Feedback:** All interactive feedback (press/click) must occur within 100ms.
- **Transitions:** Use a 200ms slide for conditional fields or expanding card details.
- **Loading:** Use shimmering skeletons in the `Surface Variant` color rather than circular spinners.