using UnityEngine;
using System.Collections;

public class UVmaterialScrollMulti : MonoBehaviour {
	public int ScrollMaterial1 = 0;
	public float Material1ScrollSpeedX = 0f;
	public float Material1ScrollSpeedY = 0f;

	public int ScrollMaterial2 = 1;
	public float Material2ScrollSpeedX = 0f;
	public float Material2ScrollSpeedY = 0f;

	void Update() {

		float offsetMat1X = Time.time * Material1ScrollSpeedX;
		float offsetMat1Y = Time.time * Material1ScrollSpeedY;

		float offsetMat2X = Time.time * Material2ScrollSpeedX;
		float offsetMat2Y = Time.time * Material2ScrollSpeedY;

		GetComponent<Renderer>().materials[ScrollMaterial1].SetTextureOffset("_MainTex", new Vector2(offsetMat1X, offsetMat1Y));
		GetComponent<Renderer>().materials[ScrollMaterial2].SetTextureOffset("_MainTex", new Vector2(offsetMat2X, offsetMat2Y));
			}
}