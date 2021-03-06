
// Constant Buffer
cbuffer externalData : register(b0)
{
	matrix world;
	matrix view;
	matrix projection;
	matrix normalWorld;
};

// Struct representing a single vertex worth of data
struct VertexShaderInput
{ 
	// Data type
	//  |
	//  |   Name          Semantic
	//  |    |                |
	//  v    v                v
	float3 position		: POSITION;    // XYZ position
	float3 normal		: NORMAL;      // XYZ normal
	float2 uv           : TEXTCOORD;   // UV coordinate
	float3 tangent		: TANGENT;
};

// Struct representing the data we're sending down the pipeline
struct VertexToPixel
{
	// Data type
	//  |
	//  |   Name          Semantic
	//  |    |                |
	//  v    v                v
	float4 position		: SV_POSITION;	// XYZW position (System Value Position)
	float3 normal       : NORMAL;
	float2 uv           : TEXTCOORD;
	float4 worldPos		: POSITION;
	float3 tangent      : TANGENT;
};

// --------------------------------------------------------
// The entry point (main method) for our vertex shader
// --------------------------------------------------------
VertexToPixel main( VertexShaderInput input )
{
	// Set up output struct
	VertexToPixel output;

	matrix worldViewProj = mul(mul(world, view), projection);

	output.worldPos = mul(float4(input.position, 1.0f), world);
	output.position = mul(float4(input.position, 1.0f), worldViewProj);

	//Copy normal
	output.normal = normalize(mul(input.normal, (float3x3) normalWorld));
	output.tangent = normalize(mul(input.tangent, (float3x3) normalWorld));

	//Copy uvs
	output.uv = input.uv;

	return output;
}