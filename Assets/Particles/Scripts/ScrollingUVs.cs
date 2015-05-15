using UnityEngine;
using System.Collections;

public class ScrollingUVs : MonoBehaviour
{
	public int materialIndex = 0;
	public Vector2 uvAnimationRate = new Vector2( 1.0f, 0.0f );
	public string textureName = "_MainTex";
	
	Vector2 uvOffset = Vector2.zero;
	
	void LateUpdate()
	{
		uvOffset += ( uvAnimationRate * Time.deltaTime );

		//GetComponent<Renderer>().materials[materialIndex].SetTextureOffset(textureName, new Vector2(offsetMat1X, offsetMat1Y));

		//GetComponent<Renderer>().materials[ScrollMaterial1].SetTextureOffset("_MainTex", new Vector2(offsetMat1X, offsetMat1Y));

		/*
		if( renderer.enabled )
		{
			renderer.materials[ materialIndex ].SetTextureOffset( textureName, uvOffset );
		}

		*/
	}
}