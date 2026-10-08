PRISMA_SERVICES := auth profile gusteau orchestration remy streaming speech-to-text
NODE_SERVICES := gateway auth profile remy gusteau orchestration streaming speech-to-text
GIT_SERVICES:= remy auth gusteau front gateway orchestration profile streaming speech-to-text
FLUTTER_SERVICES := front
PROJECT_PREFIX := lenvora

GIT_EXTRA_REPOS := \
	proto \

	docs/context \
	docs/wiki \
	docs/workflow make \

	shared/logger \
	shared/errors \
	shared/kafka-manager \
	shared/grpc-client-manager \
	shared/pg-boss-manager