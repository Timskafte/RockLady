using UnityEngine;
using System.Collections;

public class SinTranslate : MonoBehaviour {

	public float translateX = 0f;
	public float translateY = 0f;
	public float translateZ = 0f;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		transform.Translate(Mathf.Sin(Time.time * translateX)/100, Mathf.Sin(Time.time * translateY)/100, Mathf.Sin(Time.time * translateZ)/100, Space.Self);
		print(Mathf.Sin(Time.time * translateX)/100);
	}
}
