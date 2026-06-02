/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: [
    './pages/**/*.{ts,tsx}',
    './components/**/*.{ts,tsx}',
    './app/**/*.{ts,tsx}',
    './src/**/*.{ts,tsx}',
  ],
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "#165DFF",
          light: "#4080FF",
          dark: "#0E42D2",
          foreground: "#FFFFFF",
        },
        secondary: {
          DEFAULT: "#F2F3F5",
          foreground: "#1D2129",
        },
        success: {
          DEFAULT: "#00B42A",
          light: "#E8FFEA",
          foreground: "#FFFFFF",
        },
        warning: {
          DEFAULT: "#FF7D00",
          light: "#FFF3E8",
          foreground: "#FFFFFF",
        },
        danger: {
          DEFAULT: "#F53F3F",
          light: "#FFE8E8",
          foreground: "#FFFFFF",
        },
        muted: {
          DEFAULT: "#F2F3F5",
          foreground: "#86909C",
        },
        accent: {
          DEFAULT: "#F2F3F5",
          foreground: "#1D2129",
        },
        card: {
          DEFAULT: "#FFFFFF",
          foreground: "#1D2129",
        },
        popover: {
          DEFAULT: "#FFFFFF",
          foreground: "#1D2129",
        },
        destructive: {
          DEFAULT: "#F53F3F",
          foreground: "#FFFFFF",
        },
        sidebar: {
          DEFAULT: "#FFFFFF",
          foreground: "#4E5969",
        },
        nav: {
          bg: "#165DFF",
          text: "#FFFFFF",
          hover: "#4080FF",
        },
        table: {
          header: "#F2F3F5",
          border: "#E5E6E8",
          hover: "#F7F8FA",
        },
        tag: {
          gray: { bg: "#F2F3F5", text: "#4E5969" },
          blue: { bg: "#E8F3FF", text: "#165DFF" },
          green: { bg: "#E8FFEA", text: "#00B42A" },
          red: { bg: "#FFE8E8", text: "#F53F3F" },
          orange: { bg: "#FFF3E8", text: "#FF7D00" },
        },
      },
      borderRadius: {
        lg: "8px",
        md: "6px",
        sm: "4px",
      },
      fontSize: {
        'xs': ['12px', { lineHeight: '20px' }],
        'sm': ['13px', { lineHeight: '22px' }],
        'base': ['14px', { lineHeight: '22px' }],
        'lg': ['16px', { lineHeight: '24px' }],
        'xl': ['18px', { lineHeight: '28px' }],
        '2xl': ['20px', { lineHeight: '28px' }],
      },
      keyframes: {
        "accordion-down": {
          from: { height: 0 },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: 0 },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
}
