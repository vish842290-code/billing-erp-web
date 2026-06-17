# 1. SDK इमेज का इस्तेमाल करके ऐप को बिल्ड करेंगे
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# प्रोजेक्ट फाइलें कॉपी करके रीस्टोर करेंगे
COPY *.csproj ./
RUN dotnet restore

# बाकी सारा कोड कॉपी करके पब्लिश करेंगे
COPY . ./
RUN dotnet publish -c Release -o out

# 2. रनटाइम इमेज का इस्तेमाल करके ऐप को लाइव करेंगे
FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
# आपकी बताई सुधार के अनुसार पाथ सेट कर दिया है
COPY --from=build /src/out/ .

# सर्वर पोर्ट कॉन्फ़िगरेशन
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "BillingERP.Web.dll"]