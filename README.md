# Project Management

<p align="center">
	<a href="https://github.com/ZainDevX/Project-Management-Tool/actions"><img src="https://img.shields.io/badge/build-passing-22c55e?style=for-the-badge" alt="Build status"></a>
	<a href="https://github.com/ZainDevX/Project-Management-Tool"><img src="https://img.shields.io/badge/react-19-61dafb?style=for-the-badge&logo=react&logoColor=000000" alt="React 19"></a>
	<a href="https://vite.dev"><img src="https://img.shields.io/badge/vite-7-646cff?style=for-the-badge&logo=vite&logoColor=ffffff" alt="Vite"></a>
	<a href="https://redux-toolkit.js.org"><img src="https://img.shields.io/badge/redux%20toolkit-state%20management-764abc?style=for-the-badge&logo=redux&logoColor=ffffff" alt="Redux Toolkit"></a>
	<a href="https://tailwindcss.com"><img src="https://img.shields.io/badge/tailwind%20css-4-38bdf8?style=for-the-badge&logo=tailwindcss&logoColor=ffffff" alt="Tailwind CSS"></a>
</p>

A modern project management dashboard for organizing workspaces, projects, tasks, and team collaboration in one place. The app is built with React and Vite, with Redux Toolkit handling application state and Tailwind CSS powering the UI.

## Overview

This project provides a clean workspace for tracking work across teams. It includes project views, task management, analytics, team tools, and calendar-oriented planning screens.

## Features

- Workspace-based project organization
- Project and task management flows
- Team member invitations and collaboration tools
- Analytics and progress summaries
- Calendar and activity views
- Responsive dashboard layout

## Tech Stack

- React 19
- Vite
- Redux Toolkit
- React Router
- Tailwind CSS
- Recharts
- Lucide React

## Getting Started

### Prerequisites

- Node.js 18 or newer
- npm

### Installation

```bash
npm install
```

### Development

```bash
npm run dev
```

Open the local app at `http://localhost:5173`.

### Production Build

```bash
npm run build
```

### Preview the Build

```bash
npm run preview
```

## Available Scripts

- `npm run dev` starts the Vite development server.
- `npm run build` creates a production-ready build.
- `npm run preview` serves the production build locally.
- `npm run lint` runs ESLint across the project.

## Project Structure

- `src/App.jsx` application shell and routing entry point
- `src/main.jsx` application bootstrap
- `src/app/` Redux store, assets, and schema files
- `src/components/` reusable UI components
- `src/pages/` page-level views
- `src/features/` Redux feature slices
- `src/styles/` global and dashboard styles
- `public/` static assets

## Notes

The repository has been cleaned to keep only the main application source and build configuration.
