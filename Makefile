include make/main.mk

GIT_SERVICES     := auth front gateway gusteau orchestration profile remy speech-to-text streaming
NODE_SERVICES    := auth       gateway gusteau orchestration profile remy speech-to-text streaming
PRISMA_SERVICES  := auth               gusteau orchestration profile remy speech-to-text streaming
FLUTTER_SERVICES :=      front

GIT_BASE := services/auth services/gateway services/profile

PROJECT_PREFIX := lenvora
