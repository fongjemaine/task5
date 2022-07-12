#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0-apline AS build
WORKDIR /src
COPY ["task1.csproj", "."]
RUN dotnet restore "./task1.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "task1.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "task1.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "task1.dll"]