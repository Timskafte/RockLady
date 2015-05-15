using UnityEngine;
using System.Collections;

public class TextureScrolling : MonoBehaviour {

	public Vector2 uvAnimationRate1 = new Vector2( 0.0f, 0.0f );
	public string textureName1 = "_AltTex2";

	public Vector2 uvAnimationRate2 = new Vector2( 0.0f, 0.0f );
	public string textureName2 = "_AltTex3";

	Vector2 uvOffset1 = Vector2.zero;
	Vector2 uvOffset2 = Vector2.zero;

	/*

	void Awake() {
		uvOffset1 = new Vector2(Random.Range(0.0f, 1.0f), Random.Range(0.0f, 1.0f));
		uvOffset2 = new Vector2(Random.Range(0.0f, 1.0f), Random.Range(0.0f, 1.0f));
	}

*/

	void Update() {

		uvOffset1 += (uvAnimationRate1 * Time.deltaTime);
		uvOffset2 += (uvAnimationRate2 * Time.deltaTime);

		GetComponent<Renderer>().material.SetTextureOffset(textureName1, uvOffset1);
		GetComponent<Renderer>().material.SetTextureOffset(textureName2, uvOffset2);

	}
}