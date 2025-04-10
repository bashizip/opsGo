# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Modified by Patrick Bashizi in March 2025 for educational purposes

FROM golang:1.19.2 as builder
WORKDIR /app
RUN go mod init opsgo
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /opsgo

FROM gcr.io/distroless/base-debian11
WORKDIR /
COPY --from=builder /opsgo /opsgo
ENV PORT 8080
USER nonroot:nonroot
CMD ["/opsgo"]