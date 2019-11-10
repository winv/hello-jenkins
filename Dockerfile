FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 8084

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY ["src/hello-docker/hello-docker.csproj", "src/hello-docker/"]
RUN dotnet restore "src/hello-docker/hello-docker.csproj"
COPY . .
WORKDIR "/src/src/hello-docker"
RUN dotnet build "hello-docker.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "hello-docker.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "hello-docker.dll"]