using UnityEngine;
using System.Collections;

public class UnlitPartialAnimated : MonoBehaviour {
	public float scrollSpeedX = 0f;
	public float scrollSpeedY = 0f;

	void Update() {
		float offsetX = Time.time * scrollSpeedX;
		float offsetY = Time.time * scrollSpeedY;
		GetComponent<Renderer>().material.SetTextureOffset("_MainTex", new Vector2(offsetX, offsetY));
	}
}