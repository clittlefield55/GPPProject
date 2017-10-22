#include "Bullet.h"


const float Bullet::speed = 5.0f;
const float Bullet::range = 20.0f;
const float Bullet::lifetime = range / speed;

Bullet::Bullet(Mesh* mesh, Material* material) : Entity(mesh, material)
{
	this->SetScale(0.2f, 0.2f, 0.2f);
	this->SetActive(true);
}

Bullet::~Bullet()
{

}

void Bullet::Update(float deltaTime, float totalTime)
{
	if (this->IsActive() != true)
	{
		return;
	}

	if (totalTime >= spawnTime + lifetime)
	{
		this->SetActive(false);
	}

	this->Move(0.0f, 0.0f, speed * deltaTime);
}

void Bullet::Draw()
{
	if (this->IsActive() != true)
	{
		return;
	}
}

void Bullet::Collides()
{

}

void Bullet::Launch(float timeStamp)
{
	this->SetPosition(0.0f, 0.0f, 0.0f);
	this->spawnTime = timeStamp;
	this->SetActive(true);
}