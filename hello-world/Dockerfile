FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /
COPY ["hello-world/hello-world.csproj", "hello-world/"]
RUN dotnet restore "hello-world/hello-world.csproj"
COPY . .
WORKDIR "/hello-world"
RUN dotnet build "hello-world.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "hello-world.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "hello-world.dll"]