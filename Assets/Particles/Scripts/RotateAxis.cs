using UnityEngine;
using System.Collections;

public class RotateAxis : MonoBehaviour {

	public float Xrotate = 0f;
	public float Yrotate = 0f;
	public float Zrotate = 0f;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		transform.Rotate(Time.deltaTime * Xrotate,Time.deltaTime * Zrotate , Time.deltaTime * Yrotate, Space.World);
	}
}
