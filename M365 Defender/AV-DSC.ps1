Configuration EnableDefender
{
Node localhost
{
WindowsFeature "Windows-Defender"
{
Ensure = "Present"
Name = "Windows-Defender"
}
}
}
